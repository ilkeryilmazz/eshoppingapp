using Core.DataAccess;
using Core.Utilities.Results;
using Entities.Concretes;
using Entities.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Abstracts
{
    public interface IBasketDal:IEntityRepository<Basket>
    {
        List<BasketDto> GetAllBasketProductByUserId(int userId);
    }
}
