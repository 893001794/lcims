package	com.lccert.oa.db;

import com.lccert.crm.chemistry.util.ConnectionToDB;

/***
 * ≤‚ ‘ø‚≤‚ ‘
 * 
 * @author tangzp
 *
 */
public class TestDB {

	public static void main(String[] args) {
		ImsDB ct = new ImsDB();
		ct.getConnection();
	}
}
