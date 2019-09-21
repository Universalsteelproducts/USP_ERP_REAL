import org.apache.ofbiz.base.util.UtilDateTime
import java.sql.Timestamp

Timestamp now = UtilDateTime.nowTimestamp()
// Paging variables

groupId = parameters.groupId
context.groupId = groupId
