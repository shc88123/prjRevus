package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.transaction.annotation.Transactional;

public class DaoBoard {
	private JdbcTemplate jdbcTemplate;

	public DaoBoard(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public Integer count(String email) {
		Integer count = jdbcTemplate.queryForObject(
				"select count(*) from board where email=? and re_lev=0 order by wdate desc", Integer.class, email);
		return count;
	}

	public List<BeanBoard> selectAllByEmail(String email) {
		List<BeanBoard> results = jdbcTemplate.query(
				"select * from board where email=? and re_lev=0 order by wdate desc", new RowMapper<BeanBoard>() {
					@Override
					public BeanBoard mapRow(ResultSet rs, int rn) throws SQLException {
						BeanBoard bb = new BeanBoard();
						bb.setBnum(rs.getInt("bnum"));
						bb.setName(rs.getString("name"));
						bb.setPass(rs.getString("pass"));
						bb.setSubject(rs.getString("subject"));
						bb.setPosting(rs.getString("content"));
						bb.setFileName(rs.getString("file"));
						bb.setRe_ref(rs.getInt("re_ref"));
						bb.setRe_lev(rs.getInt("re_lev"));
						bb.setRe_seq(rs.getInt("re_seq"));
						bb.setReadcount(rs.getInt("readcount"));
						bb.setWdate(rs.getTimestamp("wdate"));
						bb.setEmail(rs.getString("email"));
						bb.setPostOption(rs.getString("postOption"));
						return bb;
					}
				}, email);
		return results;
	}

	public List<BeanBoard> selectAllByEmailPaging(String email, int limitA, int limitB) {
		List<BeanBoard> results = jdbcTemplate.query(
				"select * from board where email=? and re_lev=0 order by wdate desc limit ?, ?",
				new RowMapper<BeanBoard>() {
					@Override
					public BeanBoard mapRow(ResultSet rs, int rn) throws SQLException {
						BeanBoard bb = new BeanBoard();
						bb.setBnum(rs.getInt("bnum"));
						bb.setName(rs.getString("name"));
						bb.setPass(rs.getString("pass"));
						bb.setSubject(rs.getString("subject"));
						bb.setPosting(rs.getString("content"));
						bb.setFileName(rs.getString("file"));
						bb.setRe_ref(rs.getInt("re_ref"));
						bb.setRe_lev(rs.getInt("re_lev"));
						bb.setRe_seq(rs.getInt("re_seq"));
						bb.setReadcount(rs.getInt("readcount"));
						bb.setWdate(rs.getTimestamp("wdate"));
						bb.setEmail(rs.getString("email"));
						bb.setPostOption(rs.getString("postOption"));
						return bb;
					}
				}, email, limitA, limitB);
		return results;
	}

	public List<BeanBoard> selectReplyById(int bnum) {
		List<BeanBoard> results = jdbcTemplate.query(
				"select * from board where re_ref=? and re_lev>=1 order by re_seq desc", new RowMapper<BeanBoard>() {
					@Override
					public BeanBoard mapRow(ResultSet rs, int rn) throws SQLException {
						BeanBoard bb = new BeanBoard();
						bb.setBnum(rs.getInt("bnum"));
						bb.setName(rs.getString("name"));
						bb.setPass(rs.getString("pass"));
						bb.setSubject(rs.getString("subject"));
						bb.setPosting(rs.getString("content"));
						bb.setFileName(rs.getString("file"));
						bb.setRe_ref(rs.getInt("re_ref"));
						bb.setRe_lev(rs.getInt("re_lev"));
						bb.setRe_seq(rs.getInt("re_seq"));
						bb.setReadcount(rs.getInt("readcount"));
						bb.setWdate(rs.getTimestamp("wdate"));
						bb.setEmail(rs.getString("email"));
						bb.setPostOption(rs.getString("postOption"));
						return bb;
					}
				}, bnum);
		return results;
	}

	public void insert(final BeanBoard bb) {
		Integer count = jdbcTemplate.queryForObject("select max(bnum) from board ", Integer.class);
		int bnum = (count != null) ? (count + 1) : 1;
		// bnum
		bb.setBnum(bnum);
		jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"insert into board (bnum, name, content, file, re_ref, re_lev, re_seq, readcount, wdate, email, postOption) "
								+ "values (?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)");
				int z = 0;
				pstmt.setInt(++z, bb.getBnum());
				pstmt.setString(++z, bb.getName());
				pstmt.setString(++z, bb.getPosting());
				pstmt.setString(++z, bb.getFileName());
				pstmt.setInt(++z, 0);
				// pstmt.setInt(++z, bb.getBnum());
				pstmt.setInt(++z, 0);
				pstmt.setInt(++z, 0);
				pstmt.setInt(++z, 0);
				// pstmt.setDate(++z, bb.getWdate());
				pstmt.setString(++z, bb.getEmail());
				pstmt.setString(++z, bb.getPostOption());
				return pstmt;
			}
		});
	}

	public BeanBoard selectSingleBoardById(int bnum) {
		BeanBoard bb = jdbcTemplate.queryForObject("select * from board where bnum=?", new RowMapper<BeanBoard>() {
			@Override
			public BeanBoard mapRow(ResultSet rs, int rowNum) throws SQLException {
				BeanBoard bb = new BeanBoard();
				bb.setBnum(rs.getInt("bnum"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setPosting(rs.getString("content"));
				bb.setFileName(rs.getString("file"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setWdate(rs.getTimestamp("wdate"));
				bb.setEmail(rs.getString("email"));
				bb.setPostOption(rs.getString("postOption"));
				return bb;
			}
		}, bnum);
		return bb;
	}

	@Transactional
	public int boardReply(final BeanBoard bb) {
		// bnum(reply num)
		Integer count = jdbcTemplate.queryForObject("select max(bnum) from board ", Integer.class);
		int bnum = (count != null) ? (count + 1) : 1;
		bb.setBnum(bnum);
		// target board
		BeanBoard target = selectSingleBoardById(bb.getRe_ref());
		final int re_ref = target.getBnum(); // 댓글 참조 번호
		final int re_lev = target.getRe_lev() + 1; // 댓글 수준
		Integer re_seq_count = jdbcTemplate.queryForObject("select max(re_seq) from board where re_ref=?",
				Integer.class, re_ref);
		final int re_seq = (re_seq_count != null) ? (re_seq_count + 1) : 1;

		int result = jdbcTemplate.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				PreparedStatement pstmt = con.prepareStatement(
						"insert into board (bnum, name, content, file, re_ref, re_lev, re_seq, readcount, wdate, email, postOption) "
								+ "values (?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)");
				int z = 0;
				pstmt.setInt(++z, bb.getBnum());
				pstmt.setString(++z, bb.getName());
				pstmt.setString(++z, bb.getPosting());
				pstmt.setString(++z, null); // file
				pstmt.setInt(++z, re_ref); // ref
				pstmt.setInt(++z, re_lev); // lev
				pstmt.setInt(++z, re_seq); // seq
				pstmt.setInt(++z, 0);
				// pstmt.setDate(++z, bb.getWdate());
				pstmt.setString(++z, bb.getEmail());
				pstmt.setString(++z, "전체");
				return pstmt;
			}
		});
		return result;
	}
}