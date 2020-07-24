#include "VoyceFileUtils.hpp"

#include <QUrl>
#include <QFile>
#include <QDebug>

bool VoyceFileUtils::deleteFile(const QUrl &fileUrl) const
{
    auto status {false};

    QFile file(fileUrl.toLocalFile());
    if(file.exists()) {
        status = file.remove();
        if(!status) {
            qDebug() << "Error while removing file:" << file.errorString();
        }
    }
    else {
        qDebug() << "File path for delete does not exist!";
    }

    return status;
}

#ifdef ANDROID
bool VoyceFileUtils::requestAndroidPermissions()
{
    const QVector<QString> permissions {
        "android.permission.WRITE_EXTERNAL_STORAGE",
        "android.permission.READ_EXTERNAL_STORAGE"
    };

    for(const auto &permission : permissions){
        const auto result = QtAndroid::checkPermission(permission);
        if(result == QtAndroid::PermissionResult::Denied){
            auto resultHash = QtAndroid::requestPermissionsSync(QStringList {permission});
            if(resultHash[permission] == QtAndroid::PermissionResult::Denied)
                return false;
        }
    }

    return true;
}
#endif
