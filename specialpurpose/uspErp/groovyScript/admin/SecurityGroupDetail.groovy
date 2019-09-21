import org.apache.ofbiz.base.util.StringUtil
import org.apache.commons.lang.StringUtils
import org.apache.ofbiz.base.util.UtilValidate

groupId = StringUtils.trimToEmpty(parameters.groupId)
context.groupId = groupId
if (UtilValidate.isNotEmpty(groupId)) {
    securityGroupInfo = delegator.findOne("SecurityGroup", [groupId : groupId], false)
    context.securityGroupInfo = securityGroupInfo
}