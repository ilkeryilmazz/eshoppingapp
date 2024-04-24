using Business.Abstracts;
using Core.Utilities.Results;
using DataAccess.Abstracts;
using Entities.Concretes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.Concretes
{
    public class ProductManager : IProductService
    {
        IProductDal _productDal;

        public ProductManager(IProductDal productDal)
        {
            _productDal = productDal;
        }

        public IDataResult<Product> Add(Product product)
        {
            var data = _productDal.Add(product);
            return new SuccessDataResult<Product>(data);
        }

        public IDataResult<Product> Delete(Product product)
        {
            var data = _productDal.Delete(product);
            return new SuccessDataResult<Product>(data);
        }

        public IDataResult<List<Product>> GetAll()
        {
            var data = _productDal.GetAll();
            return new SuccessDataResult<List<Product>>(data);
        }

        public IDataResult<Product> GetById(int id)
        {
            var data = _productDal.Get(c=>c.Id==id);
            return new SuccessDataResult<Product>(data);
        }

        public IDataResult<Product> Update(Product product)
        {
            var data = _productDal.Update(product);
            return new SuccessDataResult<Product>(data);
        }
    }
}
