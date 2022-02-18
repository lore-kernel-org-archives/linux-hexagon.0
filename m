From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 00/18] clean up asm/uaccess.h, kill set_fs for good
Date: Fri, 18 Feb 2022 01:50:36 +0000
Message-ID: <Yg77bNZfNhSk0bVQ@zeniv-ca.linux.org.uk>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "dalias@libc.org" <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "guoren@kernel.org" <guoren@kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, linux-hexag

On Thu, Feb 17, 2022 at 07:20:11AM +0000, Christophe Leroy wrote:

> And we have also 
> user_access_begin()/user_read_access_begin()/user_write_access_begin() 
> which call access_ok() then do the real work. Could be made generic with 
> call to some arch specific __user_access_begin() and friends after the 
> access_ok() and eventually the might_fault().

Not a good idea, considering the fact that we do not want to invite
uses of "faster" variants...
