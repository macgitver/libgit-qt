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


#include "git-qt.h"

#include "git2/strarray.h"

namespace QGit {

/**
@brief Create a QStringList from a git_starray
@param[in] strings  Pointer to the git_starrray
@return A QStringList with all entries of @a strArr.
*/
QStringList Convert::toStringList(const git_strarray* strings) {
    QStringList sl;

    if (!strings)
        return sl;

    for (size_t i = 0; i < (*strings).count; i++) {
        sl << QString::fromUtf8((*strings).strings[i]);
    }

    return sl;
}

StrArray::StrArray(git_strarray* strings)
    : mStrings(strings)
{
}

StrArray::~StrArray()
{
    git_strarray_free(mStrings);
}

}
