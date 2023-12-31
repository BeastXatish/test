public class ensxtx_UTIL_SelectOption
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(ensxtx_UTIL_SelectOption.class);

    // This is used in a few places to control the formatted string used as the SelectOption label
    // The default behavior is to use format "Value - Description"
    public static String dropDownDescriptionFormat
    {
        get
        {
            return (String)ensxtx_UTIL_AppSettings.getValue(
                ensxtx_UTIL_AppSettings.EnterpriseApp, 'General.DropDownDescriptionFormat', '{0} - {1}');
        }
    }

    // Helper class to map from some type to a SelectOption
    //
    // To construct a list of SelectOptions from some list of objects,
    // override this class for the given object type, then pass it and
    // the list of objects to ensxtx_UTIL_SelectOption.buildOptionsFromList()
    public abstract class OptionBuilder
    {

        // Returns human-readable description of the item
        public virtual SelectOption getDefaultSelect()
        {
            return new SelectOption('', 'Select One');
        }

        // Returns string value of the item - used as the SelectOption value
        public virtual string getItemValue(object item)
        {
            return string.valueOf(item);
        }

        // Returns human-readable description of the item
        public virtual string getItemDescription(object item)
        {
            return string.valueOf(item);
        }

        // Returns a formatted string used as the SelectOption label
        // The default behavior is to return "Value - Description"
        public virtual string getItemLabel(object item)
        {
            string value = getItemValue(item);
            string description = getItemDescription(item);
            string formatStr = ensxtx_UTIL_SelectOption.dropDownDescriptionFormat;
            string label = string.format(formatStr, new string[] {value, description});
            return label;
        }

        // Whether or not to include this item in the created SelectOption list
        // If this method returns false, the given object will not be included
        // in the constructed SelectOption list
        public virtual boolean isItemDisplayed(object item)
        {
            return true;
        }
    }

    // With the help of an OptionBuilder class, this maps a list of objects
    // to a list of SelectOptions
    public static List<SelectOption> buildOptionsFromList(OptionBuilder builder, List<Object> items)
    {
        List<SelectOption> result = new List<SelectOption>();

        if (null != builder && null != items)
        {
            Integer itemTot = items.size();
            for (Integer itemCnt = 0 ; itemCnt < itemTot ; itemCnt++)
            {
                object item = items[itemCnt];
                string value = builder.getItemValue(item);
                if (null == value) value = '';

                if (builder.isItemDisplayed(item) && String.isNotEmpty(value))
                {
                    string label = builder.getItemlabel(item);
                    if (null == label) label = '';

                    SelectOption option = buildOption(value, label);
                    result.add(option);
                }
            }
        }
        return result;
    }
    
    // With the help of an OptionBuilder class, this maps a list of objects
    // to a list of SelectOptions, with the possibility of the default option
    public static List<SelectOption> buildOptionsFromList(OptionBuilder builder, List<Object> items, Boolean addDefaultOption)
    {
        List<SelectOption> result = new List<SelectOption>();
        if (addDefaultOption)
        {
            result.add(builder.getDefaultSelect());
        }
        result.addAll(buildOptionsFromList(builder, items));
        return result;
    }

    // Given a list of SelectOptions, returns a new list with duplicate values filtered out
    // In the case of duplicates, the first option wins
    public static List<SelectOption> getOptionsByUniqueValue(List<SelectOption> options)
    {
        List<SelectOption> result = new List<SelectOption>();
        Set<string> values = new Set<string>();
        Integer optTot = options.size();
        for (Integer optCnt = 0 ; optCnt < optTot ; optCnt++)
        {
            SelectOption option = options[optCnt];
            string value = option.getValue();
            if (!values.contains(value))
            {
                values.add(value);
                result.add(option);
            }
        }
        return result;
    }

    // Given a list of SelectOptions, returns a new list with duplicate labels filtered out
    // In the case of duplicates, the first option wins
    public static List<SelectOption> getOptionsByUniqueLabel(List<SelectOption> options)
    {
        List<SelectOption> result = new List<SelectOption>();
        Set<string> labels = new Set<string>();
        Integer optTot = options.size();
        for (Integer optCnt = 0 ; optCnt < optTot ; optCnt++)
        {
            SelectOption option = options[optCnt];
            string label = option.getLabel();
            if (!labels.contains(label))
            {
                labels.add(label);
                result.add(option);
            }
            else
            {
                System.debug(string.format('Removing duplicate labeled option: {0} - {1}',
                        new string[] {option.getValue(), option.getLabel()}));
            }
        }
        return result;
    }

    // Given a list of SelectOptions, returns a new list with
    // duplicates filtered out (duplicte == same value and label)
    public static List<SelectOption> getUniqueOptions(List<SelectOption> options)
    {
        List<SelectOption> result = new List<SelectOption>();
        Set<string> keys = new Set<string>();
        Integer optTot = options.size();
        for (Integer optCnt = 0 ; optCnt < optTot ; optCnt++)
        {
            SelectOption option = options[optCnt];
            string key = option.getValue() + '|#|' + option.getLabel();
            if (!keys.contains(key))
            {
                keys.add(key);
                result.add(option);
            }
            else
            {
                System.debug(string.format('Removing duplicate option: {0} - {1}',
                        new string[] {option.getValue(), option.getLabel()}));
            }
        }
        return result;
    }

    @testVisible
    private static SelectOption buildOption(string value, string description)
    {
        return new SelectOption(value, description);
    }
}