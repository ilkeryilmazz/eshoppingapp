using Business.Abstracts;
using Core.Entities.Concretes;
using Core.Utilities.Results;
using DataAccess.Abstracts;
using Entities.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Concretes
{
    public class UserManager : IUserService
    {
        IUserDal _userDal;

        public UserManager(IUserDal userDal)
        {
            _userDal = userDal;
        }

        public IDataResult<User> Add(User user)
        {
            var data =_userDal.Add(user);
            return new SuccessDataResult<User>(data);
        }

        public IDataResult<User> Delete(User user)
        {
            var data = _userDal.Delete(user);
            return new SuccessDataResult<User>(data);
        }

        public IDataResult<List<User>> GetAll()
        {
            var data = _userDal.GetAll();
            return new SuccessDataResult<List<User>>(data);
        }

        public IDataResult<User> GetById(int id)
        {
            throw new NotImplementedException();
        }

        public IDataResult<User> GetByMail(string mail)
        {
            var data = _userDal.Get(user=>user.Email==mail);
            return new SuccessDataResult<User>(data);
        }

        public IDataResult<User> Login(UserForLoginDto userForLoginDto)
        {
            var getUserByMail = GetByMail(userForLoginDto.Email);
            if (getUserByMail!=null && getUserByMail.Data.Password == userForLoginDto.Password) {
                return new SuccessDataResult<User>(getUserByMail.Data,"Giriş başarılı");
                
            }
            return new ErrorDataResult<User>("Şifre yanlış");
        }

        public IDataResult<User> Register(UserForRegisterDto userForRegisterDto)
        {
            User user = new User();
            user.Email = userForRegisterDto.Email;
            user.Password = userForRegisterDto.Password;
            user.UserName = userForRegisterDto.UserName;
            var data  = _userDal.Add(user);
            return new SuccessDataResult<User>(user, "Kayıt Başarılı");
        }

        public IDataResult<User> Update(User user)
        {
            var data = _userDal.Update(user);
            return new SuccessDataResult<User>(data);
        }
    }
}
