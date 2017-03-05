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

#ifndef INTRANT_LIST_PSKEL_HPP
#define INTRANT_LIST_PSKEL_HPP

#include <xsde/cxx/version.hxx>

#if (XSDE_INT_VERSION != 3020000L)
#error XSD/e runtime version mismatch
#endif

#include <xsde/cxx/config.hxx>

#ifndef XSDE_ENCODING_UTF8
#error the generated code uses the UTF-8 encodingwhile the XSD/e runtime does not (reconfigure the runtime or change the --char-encoding value)
#endif

#ifndef XSDE_STL
#error the generated code uses STL while the XSD/e runtime does not (reconfigure the runtime or add --no-stl)
#endif

#ifndef XSDE_IOSTREAM
#error the generated code uses iostream while the XSD/e runtime does not (reconfigure the runtime or add --no-iostream)
#endif

#ifndef XSDE_EXCEPTIONS
#error the generated code uses exceptions while the XSD/e runtime does not (reconfigure the runtime or add --no-exceptions)
#endif

#ifndef XSDE_LONGLONG
#error the generated code uses long long while the XSD/e runtime does not (reconfigure the runtime or add --no-long-long)
#endif

#ifdef XSDE_PARSER_VALIDATION
#error the XSD/e runtime uses validation while the generated code does not (reconfigure the runtime or remove --suppress-validation)
#endif

#ifdef XSDE_POLYMORPHIC
#error the generated code expects XSD/e runtime without polymorphism support (reconfigure the runtime or add --generate-polymorphic/--runtime-polymorphic)
#endif

#ifndef XSDE_REUSE_STYLE_TIEIN
#error the generated code uses the tiein reuse style while the XSD/e runtime does not (reconfigure the runtime or add --reuse-style-mixin or --reuse-style-none)
#endif

#ifdef XSDE_CUSTOM_ALLOCATOR
#error the XSD/e runtime uses custom allocator while the generated code does not (reconfigure the runtime or add --custom-allocator)
#endif

#include <xsde/cxx/pre.hxx>

// Begin prologue.
//

#include <xsde/cxx/hybrid/any-type.hxx>
#include <xsde/cxx/hybrid/any-type-pskel.hxx>
#include <xsde/cxx/hybrid/any-type-pimpl.hxx>

namespace xml_schema
{
  using ::xsde::cxx::hybrid::any_type;

  using ::xsde::cxx::hybrid::any_type_pskel;
  using ::xsde::cxx::hybrid::any_type_pimpl;
}


//
// End prologue.

// Forward declarations
//
namespace N_Data
{
  class Action_pskel;
  class ActionList_pskel;
  class IntrantList_pskel;
  class Intrant_pskel;
}


#include <xsde/cxx/ro-string.hxx>

#include <xsde/cxx/parser/xml-schema.hxx>

#include <xsde/cxx/parser/exceptions.hxx>

#include <xsde/cxx/parser/non-validating/parser.hxx>
#include <xsde/cxx/parser/non-validating/xml-schema-pskel.hxx>
#include <xsde/cxx/parser/non-validating/xml-schema-pimpl.hxx>

#include <xsde/cxx/parser/expat/document.hxx>

#include "IntrantList.hpp"

namespace xml_schema
{
  // Built-in XML Schema types mapping.
  //
  using ::xsde::cxx::string_sequence;
  using ::xsde::cxx::qname;
  using ::xsde::cxx::buffer;
  using ::xsde::cxx::time_zone;
  using ::xsde::cxx::gday;
  using ::xsde::cxx::gmonth;
  using ::xsde::cxx::gyear;
  using ::xsde::cxx::gmonth_day;
  using ::xsde::cxx::gyear_month;
  using ::xsde::cxx::date;
  using ::xsde::cxx::time;
  using ::xsde::cxx::date_time;
  using ::xsde::cxx::duration;

  // Base parser skeletons.
  //
  using ::xsde::cxx::parser::parser_base;
  typedef ::xsde::cxx::parser::non_validating::empty_content parser_empty_content;
  typedef ::xsde::cxx::parser::non_validating::simple_content parser_simple_content;
  typedef ::xsde::cxx::parser::non_validating::complex_content parser_complex_content;
  typedef ::xsde::cxx::parser::non_validating::list_base parser_list_base;

  // Parser skeletons and implementations for the XML Schema
  // built-in types.
  //
  using ::xsde::cxx::parser::non_validating::any_simple_type_pskel;
  using ::xsde::cxx::parser::non_validating::any_simple_type_pimpl;

  using ::xsde::cxx::parser::non_validating::byte_pskel;
  using ::xsde::cxx::parser::non_validating::byte_pimpl;

  using ::xsde::cxx::parser::non_validating::unsigned_byte_pskel;
  using ::xsde::cxx::parser::non_validating::unsigned_byte_pimpl;

  using ::xsde::cxx::parser::non_validating::short_pskel;
  using ::xsde::cxx::parser::non_validating::short_pimpl;

  using ::xsde::cxx::parser::non_validating::unsigned_short_pskel;
  using ::xsde::cxx::parser::non_validating::unsigned_short_pimpl;

  using ::xsde::cxx::parser::non_validating::int_pskel;
  using ::xsde::cxx::parser::non_validating::int_pimpl;

  using ::xsde::cxx::parser::non_validating::unsigned_int_pskel;
  using ::xsde::cxx::parser::non_validating::unsigned_int_pimpl;

  using ::xsde::cxx::parser::non_validating::long_pskel;
  using ::xsde::cxx::parser::non_validating::long_pimpl;

  using ::xsde::cxx::parser::non_validating::unsigned_long_pskel;
  using ::xsde::cxx::parser::non_validating::unsigned_long_pimpl;

  using ::xsde::cxx::parser::non_validating::integer_pskel;
  using ::xsde::cxx::parser::non_validating::integer_pimpl;

  using ::xsde::cxx::parser::non_validating::non_positive_integer_pskel;
  using ::xsde::cxx::parser::non_validating::non_positive_integer_pimpl;

  using ::xsde::cxx::parser::non_validating::non_negative_integer_pskel;
  using ::xsde::cxx::parser::non_validating::non_negative_integer_pimpl;

  using ::xsde::cxx::parser::non_validating::positive_integer_pskel;
  using ::xsde::cxx::parser::non_validating::positive_integer_pimpl;

  using ::xsde::cxx::parser::non_validating::negative_integer_pskel;
  using ::xsde::cxx::parser::non_validating::negative_integer_pimpl;

  using ::xsde::cxx::parser::non_validating::boolean_pskel;
  using ::xsde::cxx::parser::non_validating::boolean_pimpl;

  using ::xsde::cxx::parser::non_validating::float_pskel;
  using ::xsde::cxx::parser::non_validating::float_pimpl;

  using ::xsde::cxx::parser::non_validating::double_pskel;
  using ::xsde::cxx::parser::non_validating::double_pimpl;

  using ::xsde::cxx::parser::non_validating::decimal_pskel;
  using ::xsde::cxx::parser::non_validating::decimal_pimpl;

  using ::xsde::cxx::parser::non_validating::string_pskel;
  using ::xsde::cxx::parser::non_validating::string_pimpl;

  using ::xsde::cxx::parser::non_validating::normalized_string_pskel;
  using ::xsde::cxx::parser::non_validating::normalized_string_pimpl;

  using ::xsde::cxx::parser::non_validating::token_pskel;
  using ::xsde::cxx::parser::non_validating::token_pimpl;

  using ::xsde::cxx::parser::non_validating::name_pskel;
  using ::xsde::cxx::parser::non_validating::name_pimpl;

  using ::xsde::cxx::parser::non_validating::nmtoken_pskel;
  using ::xsde::cxx::parser::non_validating::nmtoken_pimpl;

  using ::xsde::cxx::parser::non_validating::nmtokens_pskel;
  using ::xsde::cxx::parser::non_validating::nmtokens_pimpl;

  using ::xsde::cxx::parser::non_validating::ncname_pskel;
  using ::xsde::cxx::parser::non_validating::ncname_pimpl;

  using ::xsde::cxx::parser::non_validating::language_pskel;
  using ::xsde::cxx::parser::non_validating::language_pimpl;

  using ::xsde::cxx::parser::non_validating::id_pskel;
  using ::xsde::cxx::parser::non_validating::id_pimpl;

  using ::xsde::cxx::parser::non_validating::idref_pskel;
  using ::xsde::cxx::parser::non_validating::idref_pimpl;

  using ::xsde::cxx::parser::non_validating::idrefs_pskel;
  using ::xsde::cxx::parser::non_validating::idrefs_pimpl;

  using ::xsde::cxx::parser::non_validating::uri_pskel;
  using ::xsde::cxx::parser::non_validating::uri_pimpl;

  using ::xsde::cxx::parser::non_validating::qname_pskel;
  using ::xsde::cxx::parser::non_validating::qname_pimpl;

  using ::xsde::cxx::parser::non_validating::base64_binary_pskel;
  using ::xsde::cxx::parser::non_validating::base64_binary_pimpl;

  using ::xsde::cxx::parser::non_validating::hex_binary_pskel;
  using ::xsde::cxx::parser::non_validating::hex_binary_pimpl;

  using ::xsde::cxx::parser::non_validating::date_pskel;
  using ::xsde::cxx::parser::non_validating::date_pimpl;

  using ::xsde::cxx::parser::non_validating::date_time_pskel;
  using ::xsde::cxx::parser::non_validating::date_time_pimpl;

  using ::xsde::cxx::parser::non_validating::duration_pskel;
  using ::xsde::cxx::parser::non_validating::duration_pimpl;

  using ::xsde::cxx::parser::non_validating::gday_pskel;
  using ::xsde::cxx::parser::non_validating::gday_pimpl;

  using ::xsde::cxx::parser::non_validating::gmonth_pskel;
  using ::xsde::cxx::parser::non_validating::gmonth_pimpl;

  using ::xsde::cxx::parser::non_validating::gmonth_day_pskel;
  using ::xsde::cxx::parser::non_validating::gmonth_day_pimpl;

  using ::xsde::cxx::parser::non_validating::gyear_pskel;
  using ::xsde::cxx::parser::non_validating::gyear_pimpl;

  using ::xsde::cxx::parser::non_validating::gyear_month_pskel;
  using ::xsde::cxx::parser::non_validating::gyear_month_pimpl;

  using ::xsde::cxx::parser::non_validating::time_pskel;
  using ::xsde::cxx::parser::non_validating::time_pimpl;

  // Read-only string.
  //
  using ::xsde::cxx::ro_string;

  // Error codes.
  //
  typedef xsde::cxx::parser::expat::xml_error parser_xml_error;

  // Exceptions.
  //
  typedef xsde::cxx::parser::exception parser_exception;
  typedef xsde::cxx::parser::xml parser_xml;

  // Document parser.
  //
  using xsde::cxx::parser::expat::document_pimpl;

  // Parser context.
  //
  typedef xsde::cxx::parser::context parser_context;
}

namespace N_Data
{
  class Action_pskel: public ::xsde::cxx::parser::non_validating::complex_content
  {
    public:
    // Parser callbacks. Override them in your implementation.
    //
    // virtual void
    // pre ();

    // Elements.
    //
    virtual void
    title (const ::std::string&);

    virtual void
    delegate (const ::std::string&);

    virtual void
    deadlineDate (const ::xml_schema::date&);

    virtual ::N_Data::Action
    post_Action () = 0;

    // Parser construction API.
    //
    void
    parsers (::xml_schema::string_pskel& /* title */,
             ::xml_schema::string_pskel& /* delegate */,
             ::xml_schema::date_pskel& /* deadlineDate */);

    // Individual element parsers.
    //
    void
    title_parser (::xml_schema::string_pskel&);

    void
    delegate_parser (::xml_schema::string_pskel&);

    void
    deadlineDate_parser (::xml_schema::date_pskel&);

    virtual void
    _reset ();

    // Constructor.
    //
    Action_pskel ();

    // Implementation details.
    //
    protected:
    Action_pskel* Action_impl_;
    Action_pskel (Action_pskel*, void*);

    protected:
    virtual bool
    _start_element_impl (const ::xsde::cxx::ro_string&,
                         const ::xsde::cxx::ro_string&);

    virtual bool
    _end_element_impl (const ::xsde::cxx::ro_string&,
                       const ::xsde::cxx::ro_string&);

    protected:
    ::xml_schema::string_pskel* title_parser_;
    ::xml_schema::string_pskel* delegate_parser_;
    ::xml_schema::date_pskel* deadlineDate_parser_;
  };

  class ActionList_pskel: public ::xsde::cxx::parser::non_validating::complex_content
  {
    public:
    // Parser callbacks. Override them in your implementation.
    //
    // virtual void
    // pre ();

    // Elements.
    //
    virtual void
    Action (const ::N_Data::Action&);

    virtual ::N_Data::ActionList*
    post_ActionList () = 0;

    // Parser construction API.
    //
    void
    parsers (::N_Data::Action_pskel& /* Action */);

    // Individual element parsers.
    //
    void
    Action_parser (::N_Data::Action_pskel&);

    virtual void
    _reset ();

    // Constructor.
    //
    ActionList_pskel ();

    // Implementation details.
    //
    protected:
    ActionList_pskel* ActionList_impl_;
    ActionList_pskel (ActionList_pskel*, void*);

    protected:
    virtual bool
    _start_element_impl (const ::xsde::cxx::ro_string&,
                         const ::xsde::cxx::ro_string&);

    virtual bool
    _end_element_impl (const ::xsde::cxx::ro_string&,
                       const ::xsde::cxx::ro_string&);

    protected:
    ::N_Data::Action_pskel* Action_parser_;
  };

  class IntrantList_pskel: public ::xsde::cxx::parser::non_validating::complex_content
  {
    public:
    // Parser callbacks. Override them in your implementation.
    //
    // virtual void
    // pre ();

    // Elements.
    //
    virtual void
    Intrant (::N_Data::Intrant*);

    virtual ::N_Data::IntrantList*
    post_IntrantList () = 0;

    // Parser construction API.
    //
    void
    parsers (::N_Data::Intrant_pskel& /* Intrant */);

    // Individual element parsers.
    //
    void
    Intrant_parser (::N_Data::Intrant_pskel&);

    virtual void
    _reset ();

    // Constructor.
    //
    IntrantList_pskel ();

    // Implementation details.
    //
    protected:
    IntrantList_pskel* IntrantList_impl_;
    IntrantList_pskel (IntrantList_pskel*, void*);

    protected:
    virtual bool
    _start_element_impl (const ::xsde::cxx::ro_string&,
                         const ::xsde::cxx::ro_string&);

    virtual bool
    _end_element_impl (const ::xsde::cxx::ro_string&,
                       const ::xsde::cxx::ro_string&);

    protected:
    ::N_Data::Intrant_pskel* Intrant_parser_;
  };

  class Intrant_pskel: public ::xsde::cxx::parser::non_validating::complex_content
  {
    public:
    // Parser callbacks. Override them in your implementation.
    //
    // virtual void
    // pre ();

    // Elements.
    //
    virtual void
    title (const ::std::string&);

    virtual void
    description (const ::std::string&);

    virtual void
    image (const ::std::string&);

    virtual void
    pdf (const ::std::string&);

    virtual void
    sound (const ::std::string&);

    virtual void
    url (const ::std::string&);

    virtual void
    deadlineDate (const ::xml_schema::date&);

    virtual void
    actions (::N_Data::ActionList*);

    virtual ::N_Data::Intrant*
    post_Intrant () = 0;

    // Parser construction API.
    //
    void
    parsers (::xml_schema::string_pskel& /* title */,
             ::xml_schema::string_pskel& /* description */,
             ::xml_schema::string_pskel& /* image */,
             ::xml_schema::string_pskel& /* pdf */,
             ::xml_schema::string_pskel& /* sound */,
             ::xml_schema::string_pskel& /* url */,
             ::xml_schema::date_pskel& /* deadlineDate */,
             ::N_Data::ActionList_pskel& /* actions */);

    // Individual element parsers.
    //
    void
    title_parser (::xml_schema::string_pskel&);

    void
    description_parser (::xml_schema::string_pskel&);

    void
    image_parser (::xml_schema::string_pskel&);

    void
    pdf_parser (::xml_schema::string_pskel&);

    void
    sound_parser (::xml_schema::string_pskel&);

    void
    url_parser (::xml_schema::string_pskel&);

    void
    deadlineDate_parser (::xml_schema::date_pskel&);

    void
    actions_parser (::N_Data::ActionList_pskel&);

    virtual void
    _reset ();

    // Constructor.
    //
    Intrant_pskel ();

    // Implementation details.
    //
    protected:
    Intrant_pskel* Intrant_impl_;
    Intrant_pskel (Intrant_pskel*, void*);

    protected:
    virtual bool
    _start_element_impl (const ::xsde::cxx::ro_string&,
                         const ::xsde::cxx::ro_string&);

    virtual bool
    _end_element_impl (const ::xsde::cxx::ro_string&,
                       const ::xsde::cxx::ro_string&);

    protected:
    ::xml_schema::string_pskel* title_parser_;
    ::xml_schema::string_pskel* description_parser_;
    ::xml_schema::string_pskel* image_parser_;
    ::xml_schema::string_pskel* pdf_parser_;
    ::xml_schema::string_pskel* sound_parser_;
    ::xml_schema::string_pskel* url_parser_;
    ::xml_schema::date_pskel* deadlineDate_parser_;
    ::N_Data::ActionList_pskel* actions_parser_;
  };
}

// Begin epilogue.
//
//
// End epilogue.

#include <xsde/cxx/post.hxx>

#endif // INTRANT_LIST_PSKEL_HPP