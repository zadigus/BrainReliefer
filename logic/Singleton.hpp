#ifndef SINGLETON_HPP
#define SINGLETON_HPP

template<class T> class Singleton
{
  public:
    static T& getInstance();

  protected:
    Singleton() { }
};

//----------------------------------------------------------------------------------
// inline / template method(s) implementation
//----------------------------------------------------------------------------------

template<class T> T& Singleton<T>::getInstance()
{
  static T instance;
  return instance;
}

#endif // SINGLETON_HPP
