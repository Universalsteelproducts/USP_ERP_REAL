import org.apache.commons.lang.StringUtils
import org.apache.ofbiz.base.util.UtilValidate
import org.apache.ofbiz.base.util.UtilMisc
import org.apache.ofbiz.base.util.UtilDateTime

contentId = StringUtils.trimToEmpty(parameters.contentId)
simpleTest = StringUtils.trimToEmpty(parameters.simpleTest)

if (UtilValidate.isNotEmpty(contentId)) {
    contentInfo = delegator.findOne("Content", UtilMisc.toMap(contentId : contentId), false)
    context.contentInfo = contentInfo

    productStoreEmailSettingInfo = delegator.findOne("ProductStoreEmailSetting", UtilMisc.toMap(productStoreId : context.productStoreId, emailType : "PRDS_TEST_EMAIL"), false)
}
context.simpleTest = simpleTest
