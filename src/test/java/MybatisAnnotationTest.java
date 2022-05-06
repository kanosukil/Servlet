import experiment.seven.dao.BookDaoAnnotation;
import experiment.seven.vo.Book;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.InputStream;
import java.util.List;

/**
 * @author VHBin
 * @date 2021/11/22 - 19:49
 */

// 使用注解的方式不需要指明字段和类属性之间的映射关系 (数据库 字段名和类属性名一致)
    // 驼峰式命名方式也无需指明两者之间关系
    // 名称不一致才需要指定字段和类属性之间的映射关系
public class MybatisAnnotationTest {
    public static void main(String[] args) {
        // 读取配置文件
        String resource = "mybatis-config-annotation.xml";
        InputStream config = MybatisAnnotationTest.class.getClassLoader().getResourceAsStream(resource);
        // 根据配置文件创建SqlSessionFactory
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(config);
        sqlSessionFactory.getConfiguration().addMapper(BookDaoAnnotation.class);
        // 通过SqlSessionFactory创建SqlSession
        SqlSession session = sqlSessionFactory.openSession();
        // 获取操作类
        BookDaoAnnotation bookDao = session.getMapper(BookDaoAnnotation.class);
        // 查询全部书籍
        List<Book> bookList = bookDao.findAll();
        System.out.println(bookList);

        Book book = new Book();
        book.setName("Name");
        book.setAuthor("Author");
        book.setPrice(123);
        book.setImage("Image");
        book.setDescription("Description");
        book.setCategory_id("2");
        System.out.println(bookDao.addBook(book));
        bookList = bookDao.findAll();
        System.out.println(bookList);
        bookList = bookDao.findBookByCategoryId("2");
        System.out.println(bookList);
        for (Book b : bookList)
            System.out.println(bookDao.deleteBook(b.getId()));
        bookList = bookDao.findAll();
        System.out.println(bookList);
        session.commit();
    }
}
