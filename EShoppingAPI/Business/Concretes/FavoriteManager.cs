using Business.Abstracts;
using Core.Entities.Concretes;
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
    public class FavoriteManager : IFavoriteService
    {
        IFavoriteDal _favoriteDal;

        public FavoriteManager(IFavoriteDal favoriteDal)
        {
            _favoriteDal = favoriteDal;
        }

        public IDataResult<Favorite> Add(Favorite favorite)
        {
            var datas = _favoriteDal.GetAll();
            foreach (var item in datas)
            {
                if (favorite.ProductId == item.ProductId && favorite.UserId == item.UserId)
                {
                    return new ErrorDataResult<Favorite>("Bu ürün zaten favorilerinizde");
                }
            }
            var data = _favoriteDal.Add(favorite);
            
            return new SuccessDataResult<Favorite>(data);
        }

        public IDataResult<Favorite> Delete(Favorite favorite)
        {
            var data = _favoriteDal.Delete(favorite);
            return new SuccessDataResult<Favorite>(data);
        }

        public IDataResult<List<Favorite>> GetAll()
        {
            var data = _favoriteDal.GetAll();
            return new SuccessDataResult<List<Favorite>>(data);
        }

        public IDataResult<List<FavoriteDto>> GetAllFavoriteProductByUserId(int userId)
        {
            var data = _favoriteDal.GetAllFavoriteProductByUserId(userId);
            return new SuccessDataResult<List<FavoriteDto>>(data);
        }

        public IDataResult<Favorite> GetById(int id)
        {
            var data = _favoriteDal.Get(c => c.UserId == id);
            return new SuccessDataResult<Favorite>(data);
        }

        public IDataResult<List<Favorite>> GetByUserId(int userId)
        {
            var data = _favoriteDal.GetAll(c=>c.UserId==userId);
            return new SuccessDataResult<List<Favorite>>(data);
        }

        public IDataResult<Favorite> Update(Favorite favorite)
        {
            var data = _favoriteDal.Update(favorite);
            return new SuccessDataResult<Favorite>(data);
        }
    }
}
