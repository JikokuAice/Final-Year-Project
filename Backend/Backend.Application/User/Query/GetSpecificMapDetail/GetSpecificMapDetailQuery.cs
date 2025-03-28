using Backend.Domain.Entity;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Backend.Application.User.Query.GetSpecificMapDetail
{
    public class GetSpecificMapDetailQuery:IRequest<Map?> 
    {
        public int Id { get; set; }
    }
}
  