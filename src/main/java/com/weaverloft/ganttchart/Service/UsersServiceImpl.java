package com.weaverloft.ganttchart.Service;

import com.weaverloft.ganttchart.dao.UsersDao;
import com.weaverloft.ganttchart.dto.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UsersServiceImpl implements UsersService{
    private UsersDao usersDao;
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    public UsersServiceImpl(UsersDao usersDao) {
        this.usersDao = usersDao;
    }

    @Override
    public Users findUserById(String id) throws Exception {
        return usersDao.findUserById(id);
    }

    @Override
    public boolean isValidPassword(String uPassword) throws Exception {
        Matcher matcher;
        if(uPassword.matches("^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{6,12}$") &&
                !Pattern.compile("\\s").matcher(uPassword).find()){
            //!영문,특문,숫자 포함 6~12글자거나 공백이 없으면
            return true;
        }
        return false;
    }

    @Override
    public int createUsers(Users users) throws Exception {
        String encodePassword = passwordEncoder.encode(users.getUPassword());
        users.setUPassword(encodePassword);
        return usersDao.createUsers(users);
    }

    @Override
    public String passwordEncoding(String rawPassword) throws Exception {
        return passwordEncoder.encode(rawPassword);
    }

    @Override
    public boolean login(String uId, String rawPassword,String encodePassword) throws Exception {
        return passwordEncoder.matches(rawPassword,encodePassword);
    }

    @Override
    public int updateUStatusNo(String uId, int uStatusNo) throws Exception {
        return usersDao.updateUStatusNo(uId,uStatusNo);
    }

    @Override
    public List<String> findIdByNameEmail(String uName, String uEmail) throws Exception {
        return usersDao.findIdByNameEmail(uName,uEmail);
    }

    @Override
    public int updatePassword(String uId, String tempPassword) throws Exception {
        String encodePassword = passwordEncoder.encode(tempPassword);
        return usersDao.updatePassword(uId,encodePassword);
    }

    @Override
    public int updateUser(Users user) throws Exception {
        String encodePassword = passwordEncoder.encode(user.getUPassword());
        user.setUPassword(encodePassword);
        return usersDao.updateUser(user);
    }

    @Override
    public int withdrawalUser(String uId, int uStatusNo)  throws Exception{
        return usersDao.updateUStatusNo(uId,uStatusNo);
    }

    @Override
    public int updateFileNo(String uId, int fileNo) throws Exception {
        return usersDao.updateFileNo(uId,fileNo);
    }

    @Override
    public List<Users> findUserList() throws Exception {
        return usersDao.findUserList();
    }


}
