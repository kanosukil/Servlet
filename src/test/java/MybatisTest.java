import experiment.seven.dao.BookDao;
import experiment.seven.vo.Book;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.InputStream;
import java.util.List;

/**
 * @author VHBin
 * @date 2021/11/22 - 12:45
 */
public class MybatisTest {
    public static void main(String[] args) {
        // 读取配置文件
        String resource = "mybatis-config.xml";
        InputStream config = MybatisTest.class.getClassLoader().getResourceAsStream(resource);
        // 根据配置文件创建SqlSessionFactory
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(config);
        // 根据SqlSessionFactory创建SqlSession
        SqlSession sqlSession = sqlSessionFactory.openSession();
        try {
            BookDao bookDao = sqlSession.getMapper(BookDao.class);
            List<Book> bookList = bookDao.findAll();
            System.out.println(bookList);

            Book newBook = new Book();
            newBook.setName("xxx");
            newBook.setAuthor("yyy");
            newBook.setPrice(20.20);
            newBook.setDescription("zzz");
            newBook.setCategory_id("2");
            bookDao.add(newBook);
            List<Book> bookListByCategoryID = bookDao.getBookByCategoryId(newBook.getCategory_id());
            System.out.println(bookListByCategoryID);
            newBook.setPrice(100);
            bookDao.update(newBook);
            bookListByCategoryID = bookDao.getBookByCategoryId(newBook.getCategory_id());
            System.out.println(bookListByCategoryID);
            bookDao.delete(newBook);
            sqlSession.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
