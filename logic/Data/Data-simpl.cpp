// Copyright (c) 2005-2011 Code Synthesis Tools CC
//
// This program was generated by CodeSynthesis XSD/e, an XML Schema
// to C++ data binding compiler for embedded systems.
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License version 2 as
// published by the Free Software Foundation.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
//
//

// Begin prologue.
//
//
// End prologue.

#include "Data-simpl.hpp"

#include <xsde/cxx/serializer/validating/string-common.hxx>

namespace N_Data
{
  // RootDir_simpl
  //

  RootDir_simpl::
  RootDir_simpl ()
  : RootDir_sskel (&base_impl_)
  {
  }

  void RootDir_simpl::
  pre (const ::N_Data::RootDir& x)
  {
    this->base_impl_.pre (x);
  }

  // DataPath_simpl
  //

  DataPath_simpl::
  DataPath_simpl ()
  : DataPath_sskel (&base_impl_)
  {
  }

  void DataPath_simpl::
  pre (const ::N_Data::DataPath& x)
  {
    this->base_impl_.pre (x);
    this->DataPath_simpl_state_.DataPath_ = &x;
  }

  ::std::string DataPath_simpl::
  name ()
  {
    return this->DataPath_simpl_state_.DataPath_->name ();
  }

  // Data_simpl
  //

  void Data_simpl::
  pre (const ::N_Data::Data& x)
  {
    this->Data_simpl_state_.Data_ = &x;
    this->Data_simpl_state_.DataPath_ = 
    this->Data_simpl_state_.Data_->DataPath ().begin ();
    this->Data_simpl_state_.DataPath_end_ = 
    this->Data_simpl_state_.Data_->DataPath ().end ();
  }

  const ::N_Data::RootDir& Data_simpl::
  RootDir ()
  {
    return this->Data_simpl_state_.Data_->RootDir ();
  }

  bool Data_simpl::
  DataPath_next ()
  {
    return this->Data_simpl_state_.DataPath_ != 
    this->Data_simpl_state_.DataPath_end_;
  }

  const ::N_Data::DataPath& Data_simpl::
  DataPath ()
  {
    return *this->Data_simpl_state_.DataPath_++;
  }
}

namespace N_Data
{
  // Data_saggr
  //

  Data_saggr::
  Data_saggr ()
  {
    this->DataPath_s_.serializers (this->string_s_);

    this->Data_s_.serializers (this->RootDir_s_,
                               this->DataPath_s_);
  }

  const char* Data_saggr::
  root_name ()
  {
    return "Data";
  }

  const char* Data_saggr::
  root_namespace ()
  {
    return "";
  }
}

// Begin epilogue.
//
//
// End epilogue.

