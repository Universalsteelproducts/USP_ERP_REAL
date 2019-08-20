import org.apache.ofbiz.base.util.UtilDateTime
import java.sql.Timestamp

Timestamp now = UtilDateTime.nowTimestamp()
// Paging variables

employeeLoginId = parameters.employeeLoginId
context.employeeLoginId = employeeLoginId
