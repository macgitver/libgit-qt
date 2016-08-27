/*
 * This file is part of libgit-qt.
 *
 * Copyright (C) 2016 Nils Fenner <nilsfenner@web.de>
 *
 * This program is free software; you can redistribute it and/or modify it under the terms of the
 * GNU General Public License (Version 2) as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
 * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program; if
 * not, see <http://www.gnu.org/licenses/>.
 */

#ifndef QGIT_H
#define QGIT_H

#include <QStringList>

struct git_strarray;

namespace QGit {

class Convert
{
public:
    static QStringList toStringList(const git_strarray* strings);
    static git_strarray* toGit(const QStringList& strings);
};

class StrArray
{
public:
    explicit StrArray(git_strarray* strings = nullptr);
    ~StrArray();

    inline operator const git_strarray*() const {
        return mStrings;
    }

    inline operator git_strarray*() const {
        return mStrings;
    }

    inline operator QStringList() const {
        return Convert::toStringList(mStrings);
    }

private:
    git_strarray* mStrings;
};

}

#endif
