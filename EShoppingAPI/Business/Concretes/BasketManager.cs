using Business.Abstracts;
using Core.Utilities.Results;
using DataAccess.Abstracts;
using Entities.Concretes;
using Entities.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Concretes
{
    public class BasketManager : IBasketService
    {
        IBasketDal _basketDal;

        public BasketManager(IBasketDal basketDal)
        {
            _basketDal = basketDal;
        }

        public IDataResult<Basket> Add(Basket basket)
        {
            var data = _basketDal.Add(basket);
            return new SuccessDataResult<Basket>(data);
        }

        public IResult Delete(Basket basket)
        {
            _basketDal.Delete(basket);
            return new SuccessResult();
        }

        public IResult DeleteAllByUserId(int userId)
        {
            var data = _basketDal.GetAll(data=>data.UserId == userId);
            foreach (var item in data)
            {
                _basketDal.Delete(item);
            }
            return new SuccessResult("Sepet Temizlendi");
        }

        public IDataResult<List<BasketDto>> GetAllBasketProductByUserId(int userId)
        {
           var data = _basketDal.GetAllBasketProductByUserId(userId);
            return new SuccessDataResult<List<BasketDto>>(data);
        }
    }
}
