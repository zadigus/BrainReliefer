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

#include "Data-pskel.hpp"

namespace N_Data
{
  // RootDir_pskel
  //

  RootDir_pskel::
  RootDir_pskel (::xml_schema::string_pskel* tiein)
  : ::xml_schema::string_pskel (tiein, 0),
    RootDir_impl_ (0)
  {
  }

  RootDir_pskel::
  RootDir_pskel (RootDir_pskel* impl, void*)
  : ::xml_schema::string_pskel (impl, 0),
    RootDir_impl_ (impl)
  {
  }

  // DataPath_pskel
  //

  void DataPath_pskel::
  name_parser (::xml_schema::string_pskel& p)
  {
    this->name_parser_ = &p;
  }

  void DataPath_pskel::
  parsers (::xml_schema::string_pskel& name)
  {
    this->name_parser_ = &name;
  }

  DataPath_pskel::
  DataPath_pskel (::xml_schema::string_pskel* tiein)
  : ::xml_schema::string_pskel (tiein, 0),
    DataPath_impl_ (0),
    name_parser_ (0)
  {
  }

  DataPath_pskel::
  DataPath_pskel (DataPath_pskel* impl, void*)
  : ::xml_schema::string_pskel (impl, 0),
    DataPath_impl_ (impl),
    name_parser_ (0)
  {
  }

  // Data_pskel
  //

  void Data_pskel::
  RootDir_parser (::N_Data::RootDir_pskel& p)
  {
    this->RootDir_parser_ = &p;
  }

  void Data_pskel::
  DataPath_parser (::N_Data::DataPath_pskel& p)
  {
    this->DataPath_parser_ = &p;
  }

  void Data_pskel::
  parsers (::N_Data::RootDir_pskel& RootDir,
           ::N_Data::DataPath_pskel& DataPath)
  {
    this->RootDir_parser_ = &RootDir;
    this->DataPath_parser_ = &DataPath;
  }

  Data_pskel::
  Data_pskel ()
  : Data_impl_ (0),
    RootDir_parser_ (0),
    DataPath_parser_ (0)
  {
  }

  Data_pskel::
  Data_pskel (Data_pskel* impl, void*)
  : ::xsde::cxx::parser::non_validating::complex_content (impl, 0),
    Data_impl_ (impl),
    RootDir_parser_ (0),
    DataPath_parser_ (0)
  {
  }
}

#include <assert.h>

namespace N_Data
{
  // RootDir_pskel
  //

  ::std::string RootDir_pskel::
  post_string ()
  {
    assert (this->string_impl_);
    return this->string_impl_->post_string ();
  }

  // DataPath_pskel
  //

  void DataPath_pskel::
  name (const ::std::string& x)
  {
    if (this->DataPath_impl_)
      this->DataPath_impl_->name (x);
  }

  void DataPath_pskel::
  _reset ()
  {
    typedef ::xml_schema::string_pskel base;
    base::_reset ();

    if (this->name_parser_)
      this->name_parser_->_reset ();
  }

  ::std::string DataPath_pskel::
  post_string ()
  {
    assert (this->string_impl_);
    return this->string_impl_->post_string ();
  }

  bool DataPath_pskel::
  _attribute_impl (const ::xsde::cxx::ro_string& ns,
                   const ::xsde::cxx::ro_string& n,
                   const ::xsde::cxx::ro_string& v)
  {
    typedef ::xml_schema::string_pskel base;
    if (base::_attribute_impl (ns, n, v))
    {
      return true;
    }

    ::xsde::cxx::parser::context& ctx = this->_context ();

    if (n == "name" && ns.empty ())
    {
      if (this->name_parser_)
      {
        this->name_parser_->pre ();
        this->name_parser_->_pre_impl (ctx);
        this->name_parser_->_characters (v);
        this->name_parser_->_post_impl ();
        this->name (this->name_parser_->post_string ());
      }

      return true;
    }

    return false;
  }

  // Data_pskel
  //

  void Data_pskel::
  RootDir (const ::N_Data::RootDir& x)
  {
    if (this->Data_impl_)
      this->Data_impl_->RootDir (x);
  }

  void Data_pskel::
  DataPath (const ::N_Data::DataPath& x)
  {
    if (this->Data_impl_)
      this->Data_impl_->DataPath (x);
  }

  void Data_pskel::
  _reset ()
  {
    if (this->resetting_)
      return;

    typedef ::xsde::cxx::parser::non_validating::complex_content base;
    base::_reset ();

    this->resetting_ = true;

    if (this->RootDir_parser_)
      this->RootDir_parser_->_reset ();

    if (this->DataPath_parser_)
      this->DataPath_parser_->_reset ();

    this->resetting_ = false;
  }

  bool Data_pskel::
  _start_element_impl (const ::xsde::cxx::ro_string& ns,
                       const ::xsde::cxx::ro_string& n)
  {
    typedef ::xsde::cxx::parser::non_validating::complex_content base;
    if (base::_start_element_impl (ns, n))
      return true;

    ::xsde::cxx::parser::context& ctx = this->_context ();

    if (n == "RootDir" && ns.empty ())
    {
      if (this->RootDir_parser_)
      {
        this->RootDir_parser_->pre ();
        ctx.nested_parser (this->RootDir_parser_);
      }

      return true;
    }

    if (n == "DataPath" && ns.empty ())
    {
      if (this->DataPath_parser_)
      {
        this->DataPath_parser_->pre ();
        ctx.nested_parser (this->DataPath_parser_);
      }

      return true;
    }

    return false;
  }

  bool Data_pskel::
  _end_element_impl (const ::xsde::cxx::ro_string& ns,
                     const ::xsde::cxx::ro_string& n)
  {
    typedef ::xsde::cxx::parser::non_validating::complex_content base;
    if (base::_end_element_impl (ns, n))
      return true;

    if (n == "RootDir" && ns.empty ())
    {
      if (this->RootDir_parser_)
      {
        this->RootDir (this->RootDir_parser_->post_RootDir ());
      }

      return true;
    }

    if (n == "DataPath" && ns.empty ())
    {
      if (this->DataPath_parser_)
      {
        this->DataPath (this->DataPath_parser_->post_DataPath ());
      }

      return true;
    }

    return false;
  }
}

// Begin epilogue.
//
//
// End epilogue.
