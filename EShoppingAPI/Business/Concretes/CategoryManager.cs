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
    public class CategoryManager : ICategoryService
    {
        ICategoryDal _categoryDal;

        public CategoryManager(ICategoryDal categoryDal)
        {
            _categoryDal = categoryDal;
        }

        public IDataResult<Category> Add(Category category)
        {
            var data = _categoryDal.Add(category);
            return new SuccessDataResult<Category>(data);
        }

        public IDataResult<Category> Delete(Category category)
        {
            var data = _categoryDal.Delete(category);
            return new SuccessDataResult<Category>(data);
        }

        public IDataResult<List<Category>> GetAll()
        {
            var data = _categoryDal.GetAll();
            return new SuccessDataResult<List<Category>>(data);
        }

        public IDataResult<Category> GetById(int id)
        {
            var data = _categoryDal.Get(category=>category.Id==id);
            return new SuccessDataResult<Category>(data);
        }

        public IDataResult<Category> Update(Category category)
        {
            var data = _categoryDal.Update(category);
            return new SuccessDataResult<Category>(data);
        }
    }
}
