public with sharing class ensxtx_UTIL_CustomerSyncSchedule implements Schedulable, ensxtx_I_ParameterizedSync
{
    private Object batchParam = null;

    public ensxtx_UTIL_CustomerSyncSchedule() {
        this(null);
    }
    public ensxtx_UTIL_CustomerSyncSchedule(Object param)
    {
        this.setBatchParam(param);
    }

    public void setBatchParam(Object value)
    {
        this.batchParam = value;
    }

    public void execute(SchedulableContext sc)
    {
        /* Enable this block of code in the Developer Console to short-circuit a
        //   runaway batch that keeps scheduling itself.
        System.debug('pretending to schedule another instance');
        return;
        //*/

        ensxtx_UTIL_SyncHelper.executeBatch('ensxtx_UTIL_CustomerSyncBatch', 'ensxtx_UTIL_CustomerSyncSchedule', 
            batchParam, (Integer) ensxtx_UTIL_AppSettings.getValue(ensxtx_UTIL_AppSettings.CustomerSyncBatch, 'SFBatchSize', 100));
    }
}