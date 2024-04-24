using Core.Utilities.Results;
using Entities.Concretes;
using Entities.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Abstracts
{
    public interface IFavoriteService
    {
        IDataResult<List<Favorite>> GetAll();
        IDataResult<List<FavoriteDto>> GetAllFavoriteProductByUserId(int userId);
        IDataResult<Favorite> GetById(int id);
        IDataResult<List<Favorite>> GetByUserId(int userId);
        IDataResult<Favorite> Add(Favorite favorite);
        IDataResult<Favorite> Update(Favorite favorite);
        IDataResult<Favorite> Delete(Favorite favorite);
    }
}
