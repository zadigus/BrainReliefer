// Copyright (c) 2005-2014 Code Synthesis Tools CC
//
// This program was generated by CodeSynthesis XSD, an XML Schema to
// C++ data binding compiler.
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
// In addition, as a special exception, Code Synthesis Tools CC gives
// permission to link this program with the Xerces-C++ library (or with
// modified versions of Xerces-C++ that use the same license as Xerces-C++),
// and distribute linked combinations including the two. You must obey
// the GNU General Public License version 2 in all respects for all of
// the code used other than Xerces-C++. If you modify this copy of the
// program, you may extend this exception to your version of the program,
// but you are not obligated to do so. If you do not wish to do so, delete
// this exception statement from your version.
//
// Furthermore, Code Synthesis Tools CC makes a special exception for
// the Free/Libre and Open Source Software (FLOSS) which is described
// in the accompanying FLOSSE file.
//

// Begin prologue.
//
//
// End prologue.

#include <xsd/cxx/pre.hxx>

#include "IntrantList.hpp"

namespace N_Data
{
  // IntrantList
  // 

  const IntrantList::Intrant_sequence& IntrantList::
  Intrant () const
  {
    return this->Intrant_;
  }

  IntrantList::Intrant_sequence& IntrantList::
  Intrant ()
  {
    return this->Intrant_;
  }

  void IntrantList::
  Intrant (const Intrant_sequence& s)
  {
    this->Intrant_ = s;
  }


  // Intrant
  // 

  const Intrant::title_type& Intrant::
  title () const
  {
    return this->title_.get ();
  }

  Intrant::title_type& Intrant::
  title ()
  {
    return this->title_.get ();
  }

  void Intrant::
  title (const title_type& x)
  {
    this->title_.set (x);
  }

  void Intrant::
  title (::std::unique_ptr< title_type > x)
  {
    this->title_.set (std::move (x));
  }

  const Intrant::description_optional& Intrant::
  description () const
  {
    return this->description_;
  }

  Intrant::description_optional& Intrant::
  description ()
  {
    return this->description_;
  }

  void Intrant::
  description (const description_type& x)
  {
    this->description_.set (x);
  }

  void Intrant::
  description (const description_optional& x)
  {
    this->description_ = x;
  }

  void Intrant::
  description (::std::unique_ptr< description_type > x)
  {
    this->description_.set (std::move (x));
  }

  const Intrant::image_sequence& Intrant::
  image () const
  {
    return this->image_;
  }

  Intrant::image_sequence& Intrant::
  image ()
  {
    return this->image_;
  }

  void Intrant::
  image (const image_sequence& s)
  {
    this->image_ = s;
  }

  const Intrant::pdf_sequence& Intrant::
  pdf () const
  {
    return this->pdf_;
  }

  Intrant::pdf_sequence& Intrant::
  pdf ()
  {
    return this->pdf_;
  }

  void Intrant::
  pdf (const pdf_sequence& s)
  {
    this->pdf_ = s;
  }

  const Intrant::sound_sequence& Intrant::
  sound () const
  {
    return this->sound_;
  }

  Intrant::sound_sequence& Intrant::
  sound ()
  {
    return this->sound_;
  }

  void Intrant::
  sound (const sound_sequence& s)
  {
    this->sound_ = s;
  }

  const Intrant::url_sequence& Intrant::
  url () const
  {
    return this->url_;
  }

  Intrant::url_sequence& Intrant::
  url ()
  {
    return this->url_;
  }

  void Intrant::
  url (const url_sequence& s)
  {
    this->url_ = s;
  }

  const Intrant::deadlineDate_optional& Intrant::
  deadlineDate () const
  {
    return this->deadlineDate_;
  }

  Intrant::deadlineDate_optional& Intrant::
  deadlineDate ()
  {
    return this->deadlineDate_;
  }

  void Intrant::
  deadlineDate (const deadlineDate_type& x)
  {
    this->deadlineDate_.set (x);
  }

  void Intrant::
  deadlineDate (const deadlineDate_optional& x)
  {
    this->deadlineDate_ = x;
  }

  void Intrant::
  deadlineDate (::std::unique_ptr< deadlineDate_type > x)
  {
    this->deadlineDate_.set (std::move (x));
  }
}

#include <xsd/cxx/xml/dom/parsing-source.hxx>

namespace N_Data
{
  // IntrantList
  //

  IntrantList::
  IntrantList ()
  : ::xml_schema::type (),
    Intrant_ (this)
  {
  }

  IntrantList::
  IntrantList (const IntrantList& x,
               ::xml_schema::flags f,
               ::xml_schema::container* c)
  : ::xml_schema::type (x, f, c),
    Intrant_ (x.Intrant_, f, this)
  {
  }

  IntrantList::
  IntrantList (const ::xercesc::DOMElement& e,
               ::xml_schema::flags f,
               ::xml_schema::container* c)
  : ::xml_schema::type (e, f | ::xml_schema::flags::base, c),
    Intrant_ (this)
  {
    if ((f & ::xml_schema::flags::base) == 0)
    {
      ::xsd::cxx::xml::dom::parser< char > p (e, true, false, false);
      this->parse (p, f);
    }
  }

  void IntrantList::
  parse (::xsd::cxx::xml::dom::parser< char >& p,
         ::xml_schema::flags f)
  {
    for (; p.more_content (); p.next_content (false))
    {
      const ::xercesc::DOMElement& i (p.cur_element ());
      const ::xsd::cxx::xml::qualified_name< char > n (
        ::xsd::cxx::xml::dom::name< char > (i));

      // Intrant
      //
      if (n.name () == "Intrant" && n.namespace_ ().empty ())
      {
        ::std::unique_ptr< Intrant_type > r (
          Intrant_traits::create (i, f, this));

        this->Intrant_.push_back (::std::move (r));
        continue;
      }

      break;
    }
  }

  IntrantList* IntrantList::
  _clone (::xml_schema::flags f,
          ::xml_schema::container* c) const
  {
    return new class IntrantList (*this, f, c);
  }

  IntrantList& IntrantList::
  operator= (const IntrantList& x)
  {
    if (this != &x)
    {
      static_cast< ::xml_schema::type& > (*this) = x;
      this->Intrant_ = x.Intrant_;
    }

    return *this;
  }

  IntrantList::
  ~IntrantList ()
  {
  }

  // Intrant
  //

  Intrant::
  Intrant (const title_type& title)
  : ::xml_schema::type (),
    title_ (title, this),
    description_ (this),
    image_ (this),
    pdf_ (this),
    sound_ (this),
    url_ (this),
    deadlineDate_ (this)
  {
  }

  Intrant::
  Intrant (const Intrant& x,
           ::xml_schema::flags f,
           ::xml_schema::container* c)
  : ::xml_schema::type (x, f, c),
    title_ (x.title_, f, this),
    description_ (x.description_, f, this),
    image_ (x.image_, f, this),
    pdf_ (x.pdf_, f, this),
    sound_ (x.sound_, f, this),
    url_ (x.url_, f, this),
    deadlineDate_ (x.deadlineDate_, f, this)
  {
  }

  Intrant::
  Intrant (const ::xercesc::DOMElement& e,
           ::xml_schema::flags f,
           ::xml_schema::container* c)
  : ::xml_schema::type (e, f | ::xml_schema::flags::base, c),
    title_ (this),
    description_ (this),
    image_ (this),
    pdf_ (this),
    sound_ (this),
    url_ (this),
    deadlineDate_ (this)
  {
    if ((f & ::xml_schema::flags::base) == 0)
    {
      ::xsd::cxx::xml::dom::parser< char > p (e, true, false, false);
      this->parse (p, f);
    }
  }

  void Intrant::
  parse (::xsd::cxx::xml::dom::parser< char >& p,
         ::xml_schema::flags f)
  {
    for (; p.more_content (); p.next_content (false))
    {
      const ::xercesc::DOMElement& i (p.cur_element ());
      const ::xsd::cxx::xml::qualified_name< char > n (
        ::xsd::cxx::xml::dom::name< char > (i));

      // title
      //
      if (n.name () == "title" && n.namespace_ ().empty ())
      {
        ::std::unique_ptr< title_type > r (
          title_traits::create (i, f, this));

        if (!title_.present ())
        {
          this->title_.set (::std::move (r));
          continue;
        }
      }

      // description
      //
      if (n.name () == "description" && n.namespace_ ().empty ())
      {
        ::std::unique_ptr< description_type > r (
          description_traits::create (i, f, this));

        if (!this->description_)
        {
          this->description_.set (::std::move (r));
          continue;
        }
      }

      // image
      //
      if (n.name () == "image" && n.namespace_ ().empty ())
      {
        ::std::unique_ptr< image_type > r (
          image_traits::create (i, f, this));

        this->image_.push_back (::std::move (r));
        continue;
      }

      // pdf
      //
      if (n.name () == "pdf" && n.namespace_ ().empty ())
      {
        ::std::unique_ptr< pdf_type > r (
          pdf_traits::create (i, f, this));

        this->pdf_.push_back (::std::move (r));
        continue;
      }

      // sound
      //
      if (n.name () == "sound" && n.namespace_ ().empty ())
      {
        ::std::unique_ptr< sound_type > r (
          sound_traits::create (i, f, this));

        this->sound_.push_back (::std::move (r));
        continue;
      }

      // url
      //
      if (n.name () == "url" && n.namespace_ ().empty ())
      {
        ::std::unique_ptr< url_type > r (
          url_traits::create (i, f, this));

        this->url_.push_back (::std::move (r));
        continue;
      }

      // deadlineDate
      //
      if (n.name () == "deadlineDate" && n.namespace_ ().empty ())
      {
        ::std::unique_ptr< deadlineDate_type > r (
          deadlineDate_traits::create (i, f, this));

        if (!this->deadlineDate_)
        {
          this->deadlineDate_.set (::std::move (r));
          continue;
        }
      }

      break;
    }

    if (!title_.present ())
    {
      throw ::xsd::cxx::tree::expected_element< char > (
        "title",
        "");
    }
  }

  Intrant* Intrant::
  _clone (::xml_schema::flags f,
          ::xml_schema::container* c) const
  {
    return new class Intrant (*this, f, c);
  }

  Intrant& Intrant::
  operator= (const Intrant& x)
  {
    if (this != &x)
    {
      static_cast< ::xml_schema::type& > (*this) = x;
      this->title_ = x.title_;
      this->description_ = x.description_;
      this->image_ = x.image_;
      this->pdf_ = x.pdf_;
      this->sound_ = x.sound_;
      this->url_ = x.url_;
      this->deadlineDate_ = x.deadlineDate_;
    }

    return *this;
  }

  Intrant::
  ~Intrant ()
  {
  }
}

#include <istream>
#include <xsd/cxx/xml/sax/std-input-source.hxx>
#include <xsd/cxx/tree/error-handler.hxx>

namespace N_Data
{
  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (const ::std::string& u,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xsd::cxx::xml::auto_initializer i (
      (f & ::xml_schema::flags::dont_initialize) == 0,
      (f & ::xml_schema::flags::keep_dom) == 0);

    ::xsd::cxx::tree::error_handler< char > h;

    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::xsd::cxx::xml::dom::parse< char > (
        u, h, p, f));

    h.throw_if_failed< ::xsd::cxx::tree::parsing< char > > ();

    return ::std::unique_ptr< ::N_Data::IntrantList > (
      ::N_Data::IntrantList_ (
        std::move (d), f | ::xml_schema::flags::own_dom, p));
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (const ::std::string& u,
                ::xml_schema::error_handler& h,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xsd::cxx::xml::auto_initializer i (
      (f & ::xml_schema::flags::dont_initialize) == 0,
      (f & ::xml_schema::flags::keep_dom) == 0);

    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::xsd::cxx::xml::dom::parse< char > (
        u, h, p, f));

    if (!d.get ())
      throw ::xsd::cxx::tree::parsing< char > ();

    return ::std::unique_ptr< ::N_Data::IntrantList > (
      ::N_Data::IntrantList_ (
        std::move (d), f | ::xml_schema::flags::own_dom, p));
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (const ::std::string& u,
                ::xercesc::DOMErrorHandler& h,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::xsd::cxx::xml::dom::parse< char > (
        u, h, p, f));

    if (!d.get ())
      throw ::xsd::cxx::tree::parsing< char > ();

    return ::std::unique_ptr< ::N_Data::IntrantList > (
      ::N_Data::IntrantList_ (
        std::move (d), f | ::xml_schema::flags::own_dom, p));
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (::std::istream& is,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xsd::cxx::xml::auto_initializer i (
      (f & ::xml_schema::flags::dont_initialize) == 0,
      (f & ::xml_schema::flags::keep_dom) == 0);

    ::xsd::cxx::xml::sax::std_input_source isrc (is);
    return ::N_Data::IntrantList_ (isrc, f, p);
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (::std::istream& is,
                ::xml_schema::error_handler& h,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xsd::cxx::xml::auto_initializer i (
      (f & ::xml_schema::flags::dont_initialize) == 0,
      (f & ::xml_schema::flags::keep_dom) == 0);

    ::xsd::cxx::xml::sax::std_input_source isrc (is);
    return ::N_Data::IntrantList_ (isrc, h, f, p);
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (::std::istream& is,
                ::xercesc::DOMErrorHandler& h,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xsd::cxx::xml::sax::std_input_source isrc (is);
    return ::N_Data::IntrantList_ (isrc, h, f, p);
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (::std::istream& is,
                const ::std::string& sid,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xsd::cxx::xml::auto_initializer i (
      (f & ::xml_schema::flags::dont_initialize) == 0,
      (f & ::xml_schema::flags::keep_dom) == 0);

    ::xsd::cxx::xml::sax::std_input_source isrc (is, sid);
    return ::N_Data::IntrantList_ (isrc, f, p);
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (::std::istream& is,
                const ::std::string& sid,
                ::xml_schema::error_handler& h,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xsd::cxx::xml::auto_initializer i (
      (f & ::xml_schema::flags::dont_initialize) == 0,
      (f & ::xml_schema::flags::keep_dom) == 0);

    ::xsd::cxx::xml::sax::std_input_source isrc (is, sid);
    return ::N_Data::IntrantList_ (isrc, h, f, p);
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (::std::istream& is,
                const ::std::string& sid,
                ::xercesc::DOMErrorHandler& h,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xsd::cxx::xml::sax::std_input_source isrc (is, sid);
    return ::N_Data::IntrantList_ (isrc, h, f, p);
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (::xercesc::InputSource& i,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xsd::cxx::tree::error_handler< char > h;

    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::xsd::cxx::xml::dom::parse< char > (
        i, h, p, f));

    h.throw_if_failed< ::xsd::cxx::tree::parsing< char > > ();

    return ::std::unique_ptr< ::N_Data::IntrantList > (
      ::N_Data::IntrantList_ (
        std::move (d), f | ::xml_schema::flags::own_dom, p));
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (::xercesc::InputSource& i,
                ::xml_schema::error_handler& h,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::xsd::cxx::xml::dom::parse< char > (
        i, h, p, f));

    if (!d.get ())
      throw ::xsd::cxx::tree::parsing< char > ();

    return ::std::unique_ptr< ::N_Data::IntrantList > (
      ::N_Data::IntrantList_ (
        std::move (d), f | ::xml_schema::flags::own_dom, p));
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (::xercesc::InputSource& i,
                ::xercesc::DOMErrorHandler& h,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::xsd::cxx::xml::dom::parse< char > (
        i, h, p, f));

    if (!d.get ())
      throw ::xsd::cxx::tree::parsing< char > ();

    return ::std::unique_ptr< ::N_Data::IntrantList > (
      ::N_Data::IntrantList_ (
        std::move (d), f | ::xml_schema::flags::own_dom, p));
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (const ::xercesc::DOMDocument& doc,
                ::xml_schema::flags f,
                const ::xml_schema::properties& p)
  {
    if (f & ::xml_schema::flags::keep_dom)
    {
      ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
        static_cast< ::xercesc::DOMDocument* > (doc.cloneNode (true)));

      return ::std::unique_ptr< ::N_Data::IntrantList > (
        ::N_Data::IntrantList_ (
          std::move (d), f | ::xml_schema::flags::own_dom, p));
    }

    const ::xercesc::DOMElement& e (*doc.getDocumentElement ());
    const ::xsd::cxx::xml::qualified_name< char > n (
      ::xsd::cxx::xml::dom::name< char > (e));

    if (n.name () == "IntrantList" &&
        n.namespace_ () == "")
    {
      ::std::unique_ptr< ::N_Data::IntrantList > r (
        ::xsd::cxx::tree::traits< ::N_Data::IntrantList, char >::create (
          e, f, 0));
      return r;
    }

    throw ::xsd::cxx::tree::unexpected_element < char > (
      n.name (),
      n.namespace_ (),
      "IntrantList",
      "");
  }

  ::std::unique_ptr< ::N_Data::IntrantList >
  IntrantList_ (::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d,
                ::xml_schema::flags f,
                const ::xml_schema::properties&)
  {
    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > c (
      ((f & ::xml_schema::flags::keep_dom) &&
       !(f & ::xml_schema::flags::own_dom))
      ? static_cast< ::xercesc::DOMDocument* > (d->cloneNode (true))
      : 0);

    ::xercesc::DOMDocument& doc (c.get () ? *c : *d);
    const ::xercesc::DOMElement& e (*doc.getDocumentElement ());

    const ::xsd::cxx::xml::qualified_name< char > n (
      ::xsd::cxx::xml::dom::name< char > (e));

    if (f & ::xml_schema::flags::keep_dom)
      doc.setUserData (::xml_schema::dom::tree_node_key,
                       (c.get () ? &c : &d),
                       0);

    if (n.name () == "IntrantList" &&
        n.namespace_ () == "")
    {
      ::std::unique_ptr< ::N_Data::IntrantList > r (
        ::xsd::cxx::tree::traits< ::N_Data::IntrantList, char >::create (
          e, f, 0));
      return r;
    }

    throw ::xsd::cxx::tree::unexpected_element < char > (
      n.name (),
      n.namespace_ (),
      "IntrantList",
      "");
  }
}

#include <ostream>
#include <xsd/cxx/tree/error-handler.hxx>
#include <xsd/cxx/xml/dom/serialization-source.hxx>

namespace N_Data
{
  void
  operator<< (::xercesc::DOMElement& e, const IntrantList& i)
  {
    e << static_cast< const ::xml_schema::type& > (i);

    // Intrant
    //
    for (IntrantList::Intrant_const_iterator
         b (i.Intrant ().begin ()), n (i.Intrant ().end ());
         b != n; ++b)
    {
      ::xercesc::DOMElement& s (
        ::xsd::cxx::xml::dom::create_element (
          "Intrant",
          e));

      s << *b;
    }
  }

  void
  IntrantList_ (::std::ostream& o,
                const ::N_Data::IntrantList& s,
                const ::xml_schema::namespace_infomap& m,
                const ::std::string& e,
                ::xml_schema::flags f)
  {
    ::xsd::cxx::xml::auto_initializer i (
      (f & ::xml_schema::flags::dont_initialize) == 0);

    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::N_Data::IntrantList_ (s, m, f));

    ::xsd::cxx::tree::error_handler< char > h;

    ::xsd::cxx::xml::dom::ostream_format_target t (o);
    if (!::xsd::cxx::xml::dom::serialize (t, *d, e, h, f))
    {
      h.throw_if_failed< ::xsd::cxx::tree::serialization< char > > ();
    }
  }

  void
  IntrantList_ (::std::ostream& o,
                const ::N_Data::IntrantList& s,
                ::xml_schema::error_handler& h,
                const ::xml_schema::namespace_infomap& m,
                const ::std::string& e,
                ::xml_schema::flags f)
  {
    ::xsd::cxx::xml::auto_initializer i (
      (f & ::xml_schema::flags::dont_initialize) == 0);

    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::N_Data::IntrantList_ (s, m, f));
    ::xsd::cxx::xml::dom::ostream_format_target t (o);
    if (!::xsd::cxx::xml::dom::serialize (t, *d, e, h, f))
    {
      throw ::xsd::cxx::tree::serialization< char > ();
    }
  }

  void
  IntrantList_ (::std::ostream& o,
                const ::N_Data::IntrantList& s,
                ::xercesc::DOMErrorHandler& h,
                const ::xml_schema::namespace_infomap& m,
                const ::std::string& e,
                ::xml_schema::flags f)
  {
    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::N_Data::IntrantList_ (s, m, f));
    ::xsd::cxx::xml::dom::ostream_format_target t (o);
    if (!::xsd::cxx::xml::dom::serialize (t, *d, e, h, f))
    {
      throw ::xsd::cxx::tree::serialization< char > ();
    }
  }

  void
  IntrantList_ (::xercesc::XMLFormatTarget& t,
                const ::N_Data::IntrantList& s,
                const ::xml_schema::namespace_infomap& m,
                const ::std::string& e,
                ::xml_schema::flags f)
  {
    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::N_Data::IntrantList_ (s, m, f));

    ::xsd::cxx::tree::error_handler< char > h;

    if (!::xsd::cxx::xml::dom::serialize (t, *d, e, h, f))
    {
      h.throw_if_failed< ::xsd::cxx::tree::serialization< char > > ();
    }
  }

  void
  IntrantList_ (::xercesc::XMLFormatTarget& t,
                const ::N_Data::IntrantList& s,
                ::xml_schema::error_handler& h,
                const ::xml_schema::namespace_infomap& m,
                const ::std::string& e,
                ::xml_schema::flags f)
  {
    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::N_Data::IntrantList_ (s, m, f));
    if (!::xsd::cxx::xml::dom::serialize (t, *d, e, h, f))
    {
      throw ::xsd::cxx::tree::serialization< char > ();
    }
  }

  void
  IntrantList_ (::xercesc::XMLFormatTarget& t,
                const ::N_Data::IntrantList& s,
                ::xercesc::DOMErrorHandler& h,
                const ::xml_schema::namespace_infomap& m,
                const ::std::string& e,
                ::xml_schema::flags f)
  {
    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::N_Data::IntrantList_ (s, m, f));
    if (!::xsd::cxx::xml::dom::serialize (t, *d, e, h, f))
    {
      throw ::xsd::cxx::tree::serialization< char > ();
    }
  }

  void
  IntrantList_ (::xercesc::DOMDocument& d,
                const ::N_Data::IntrantList& s,
                ::xml_schema::flags)
  {
    ::xercesc::DOMElement& e (*d.getDocumentElement ());
    const ::xsd::cxx::xml::qualified_name< char > n (
      ::xsd::cxx::xml::dom::name< char > (e));

    if (n.name () == "IntrantList" &&
        n.namespace_ () == "")
    {
      e << s;
    }
    else
    {
      throw ::xsd::cxx::tree::unexpected_element < char > (
        n.name (),
        n.namespace_ (),
        "IntrantList",
        "");
    }
  }

  ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument >
  IntrantList_ (const ::N_Data::IntrantList& s,
                const ::xml_schema::namespace_infomap& m,
                ::xml_schema::flags f)
  {
    ::xml_schema::dom::unique_ptr< ::xercesc::DOMDocument > d (
      ::xsd::cxx::xml::dom::serialize< char > (
        "IntrantList",
        "",
        m, f));

    ::N_Data::IntrantList_ (*d, s, f);
    return d;
  }

  void
  operator<< (::xercesc::DOMElement& e, const Intrant& i)
  {
    e << static_cast< const ::xml_schema::type& > (i);

    // title
    //
    {
      ::xercesc::DOMElement& s (
        ::xsd::cxx::xml::dom::create_element (
          "title",
          e));

      s << i.title ();
    }

    // description
    //
    if (i.description ())
    {
      ::xercesc::DOMElement& s (
        ::xsd::cxx::xml::dom::create_element (
          "description",
          e));

      s << *i.description ();
    }

    // image
    //
    for (Intrant::image_const_iterator
         b (i.image ().begin ()), n (i.image ().end ());
         b != n; ++b)
    {
      ::xercesc::DOMElement& s (
        ::xsd::cxx::xml::dom::create_element (
          "image",
          e));

      s << *b;
    }

    // pdf
    //
    for (Intrant::pdf_const_iterator
         b (i.pdf ().begin ()), n (i.pdf ().end ());
         b != n; ++b)
    {
      ::xercesc::DOMElement& s (
        ::xsd::cxx::xml::dom::create_element (
          "pdf",
          e));

      s << *b;
    }

    // sound
    //
    for (Intrant::sound_const_iterator
         b (i.sound ().begin ()), n (i.sound ().end ());
         b != n; ++b)
    {
      ::xercesc::DOMElement& s (
        ::xsd::cxx::xml::dom::create_element (
          "sound",
          e));

      s << *b;
    }

    // url
    //
    for (Intrant::url_const_iterator
         b (i.url ().begin ()), n (i.url ().end ());
         b != n; ++b)
    {
      ::xercesc::DOMElement& s (
        ::xsd::cxx::xml::dom::create_element (
          "url",
          e));

      s << *b;
    }

    // deadlineDate
    //
    if (i.deadlineDate ())
    {
      ::xercesc::DOMElement& s (
        ::xsd::cxx::xml::dom::create_element (
          "deadlineDate",
          e));

      s << *i.deadlineDate ();
    }
  }
}

#include <xsd/cxx/post.hxx>

// Begin epilogue.
//
//
// End epilogue.

