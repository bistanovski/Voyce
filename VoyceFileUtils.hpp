#ifndef VOYCEFILEUTILS_HPP
#define VOYCEFILEUTILS_HPP

#include <QObject>

#ifdef ANDROID
#include <QtAndroidExtras>
#endif

class VoyceFileUtils : public QObject
{
    Q_OBJECT

public:
    explicit VoyceFileUtils(QObject *parent = nullptr) : QObject(parent) {}
    Q_INVOKABLE bool deleteFile(const QUrl &fileUrl) const;

#ifdef ANDROID
    Q_INVOKABLE bool requestAndroidPermissions();
#endif

};

#endif // VOYCEFILEUTILS_HPP
