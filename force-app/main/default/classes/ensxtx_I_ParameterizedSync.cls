// ensxtx_I_ParameterizedSync
//
// This interface is implemented by sync schedule and sync batch classes to allow one batch to
// send a string parameter to the next batch. The first run will start
// with no parameter, and stop at MAX_ROWS. It will then pass the last customer number it completed
// into the launch of the next scheduled batch, and the next batch will use that customer number
// as a search param so it can continue where the first batch left off
public interface ensxtx_I_ParameterizedSync
{
    void setBatchParam(Object value);
}