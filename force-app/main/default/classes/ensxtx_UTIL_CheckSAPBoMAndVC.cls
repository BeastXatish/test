global with sharing  class ensxtx_UTIL_CheckSAPBoMAndVC
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(ensxtx_UTIL_CheckSAPBoMAndVC.class);

    private static Object utilCheckSapBomAndVcObject = null;

    public static ensxtx_I_SAPBoMAndVC loadUtilSapBomAndVc()
    {
        if (utilCheckSapBomAndVcObject == null)
        {
            Type utilCheckSapBomAndVcType = Type.forName('ensxtx_UTIL_SAPBoMAndVC');
            if (utilCheckSapBomAndVcType != null) utilCheckSapBomAndVcObject = utilCheckSapBomAndVcType.newInstance();
        }
        return (ensxtx_I_SAPBoMAndVC) utilCheckSapBomAndVcObject;
    }
}