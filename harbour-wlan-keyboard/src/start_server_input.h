#ifndef START_SERVER_INPUT_H
#define START_SERVER_INPUT_H

#include <QObject>

class StartServerInput : public QObject
{
    Q_OBJECT
public:
    explicit StartServerInput(QObject *parent = 0);

signals:

public slots:

private:
    bool m_broadcast;
};

#endif // START_SERVER_INPUT_H
