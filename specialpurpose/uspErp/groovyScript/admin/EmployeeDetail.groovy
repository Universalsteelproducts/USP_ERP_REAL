import org.apache.ofbiz.base.util.StringUtil
import org.apache.commons.lang.StringUtils
import org.apache.ofbiz.base.util.UtilValidate

employeeLoginId = StringUtils.trimToEmpty(parameters.employeeLoginId)
context.employeeLoginId = employeeLoginId
if (UtilValidate.isNotEmpty(employeeLoginId)) {
    employeeInfo = delegator.findOne("UserLogin", [userLoginId : employeeLoginId], false)
    context.employeeInfo = employeeInfo
}