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
    public interface IBasketService
    {
        IDataResult<Basket> Add(Basket basket);
        IDataResult<List<BasketDto>> GetAllBasketProductByUserId(int userId);
        IResult DeleteAllByUserId(int userId);
        IResult Delete(Basket basket);
    }
}
