import org.apache.commons.lang.StringUtils
import org.apache.ofbiz.base.util.UtilValidate
import org.apache.ofbiz.base.util.UtilMisc
import org.apache.ofbiz.base.util.UtilDateTime

contentId = StringUtils.trimToEmpty(parameters.contentId)
dataResourceTypeId = ""
objectInfo = ""
statusDesc = "Inactive"
statusId = "EMAIL_DEACTIVATED"
lastUpdatedStamp = ""
createdStamp = ""
contentTypeId = ""
nowTs = UtilDateTime.nowTimestamp()

if (UtilValidate.isNotEmpty(contentId)) {
    contentInfo = delegator.findOne("Content", UtilMisc.toMap(contentId : contentId), false)
    lastUpdatedStamp = UtilDateTime.timeStampToString(contentInfo.lastUpdatedStamp, "yyyy-MM-dd HH:mm a", context.timeZone, context.local)
    createdStamp = UtilDateTime.timeStampToString(contentInfo.createdStamp, "yyyy-MM-dd HH:mm a", context.timeZone, context.local)
    contentTypeId = contentInfo.contentTypeId
    context.contentInfo = contentInfo


    dataResource = contentInfo.getRelatedOne("DataResource")
    if (UtilValidate.isNotEmpty(dataResource)) {
        electronicText = dataResource.getRelatedOne("ElectronicText")
        if(UtilValidate.isNotEmpty(electronicText)) {
            context.eText = electronicText.textData
        }
        context.dataResource = dataResource
        dataResourceTypeId = dataResource.dataResourceTypeId
        objectInfo = dataResource.objectInfo
    }

    if(contentInfo.statusId != null && contentInfo.statusId != "") {
        statusId = contentInfo.statusId
    }
    if(statusId != "EMAIL_PUBLISHED") {
        statusId = "EMAIL_DEACTIVATED"
    }
    statusItem = delegator.findOne("StatusItem", UtilMisc.toMap(statusId : statusId), false)
    statusDesc = statusItem.description
    statusId = statusItem.statusId
} else {
    contentTypeId = "USP_EMAIL_TEMPLATE"
    if(context.curdType == "C") {
        createdStamp = UtilDateTime.timeStampToString(nowTs, "yyyy-MM-dd HH:mm a", context.timeZone, context.local)
    }
}

context.statusDesc = statusDesc
context.statusId = statusId
context.objectInfo = objectInfo
context.createdStamp = createdStamp
context.lastUpdatedStamp = lastUpdatedStamp
context.dataResourceTypeId = dataResourceTypeId
context.contentTypeId = contentTypeId
