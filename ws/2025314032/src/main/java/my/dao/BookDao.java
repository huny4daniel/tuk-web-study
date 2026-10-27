package my.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import my.model.Book;
import my.util.JdbcUtil;

public class BookDao {

	public void insert(Connection conn, Book book)
			throws SQLException {
		PreparedStatement pstmt=null;
		try {
			pstmt = conn.prepareStatement
					("insert into book (name,author,isbn,publisher,price,image)"
					+ " values(?,?,?,?,?,?)");
			pstmt.setString(1, book.getName());
			pstmt.setString(2, book.getAuthor());
			pstmt.setString(3, book.getIsbn());
			pstmt.setString(4, book.getPublisher());
			pstmt.setInt(5, book.getPrice());
			pstmt.setString(6, book.getImage());
			pstmt.executeUpdate();
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}

	public List<Book> selectList(Connection conn)
			throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Book> bookList = null;
		try {
			pstmt = conn.prepareStatement
					("select * from book ");
			rs = pstmt.executeQuery();
			bookList = new ArrayList<Book>();
			while (rs.next()){
				Book book = new Book();
				book.setBookId(rs.getInt(1));
				book.setName(rs.getString(2));
				book.setAuthor(rs.getString(3));
				book.setIsbn(rs.getString(4));
				book.setPublisher(rs.getString(5));
				book.setPrice(rs.getInt(6));
				book.setImage(rs.getString(7));
				bookList.add(book);
			}
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		return bookList;
	}
}
