import org.apache.commons.lang.StringUtils
import org.apache.ofbiz.base.util.UtilValidate

productStoreId = context.productStoreId

//securityGroup drop down values for the search section
securityGroups = delegator.findList("SecurityGroup", null, null, null, null, false)
if (UtilValidate.isNotEmpty(securityGroups)) {
    context.securityGroups =securityGroups
}

//search filtering
srchUserLoginId = StringUtils.trimToEmpty(parameters.srchEmployeeId)
searchGroupId = StringUtils.trimToEmpty(parameters.searchGroupId)

// User Login Id
if(UtilValidate.isNotEmpty(srchUserLoginId)) {
    context.srchUserLoginId=srchUserLoginId
}

// groupId
if(UtilValidate.isNotEmpty(searchGroupId)) {
    context.searchGroupId=searchGroupId
}