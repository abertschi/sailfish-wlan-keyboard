#ifndef KEY_MAPPER_H

#include <Qt>

#define KEY_MAPPER_H

class KeyMapper
{
public:
    KeyMapper();

    Qt::Key createQtKey(QString key);



};

#endif // KEY_MAPPER_H
