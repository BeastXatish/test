// ensxtx_I_SAPBoMAndVC
//
// This interface is implemented for Bundle BoM and VC
public interface ensxtx_I_SAPBoMAndVC
{
    Void updateBOMLinesFromSAP(Map<String, Object> params);
    Void updateSFObjectFromObjSapBomAndVc(Map<String, Object> params);
    Void setSaveResult(Map<String, Object> params);
    Void updateBoMVcStatus(Map<String, Object> params);
    Void setNumberSapBoMVCJSONMap(Map<String, Object> params);
    Void updateSapBoMVCIds(Map<String, Object> params);
}