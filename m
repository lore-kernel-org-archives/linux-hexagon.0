From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 03/14] nds32: fix access_ok() checks in get/put_user
Date: Mon, 14 Feb 2022 17:10:05 +0000
Message-ID: <8a6e309687d647e3aef8a88bdb0922af@AcuMS.aculab.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-4-arnd@kernel.org> <YgqK1ihlJvRFHJ9h@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <YgqK1ihlJvRFHJ9h@infradead.org>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Christoph Hellwig' <hch@infradead.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "dalias@libc.org" <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "guoren@kernel.org" <guoren@kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.k>

From: Christoph Hellwig
> Sent: 14 February 2022 17:01
> 
> On Mon, Feb 14, 2022 at 05:34:41PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The get_user()/put_user() functions are meant to check for
> > access_ok(), while the __get_user()/__put_user() functions
> > don't.
> >
> > This broke in 4.19 for nds32, when it gained an extraneous
> > check in __get_user(), but lost the check it needs in
> > __put_user().
> 
> Can we follow the lead of MIPS (which this was originally copied
> from I think) and kill the pointless __get/put_user_check wrapper
> that just obsfucate the code?

Is it possible to make all these architectures fall back to
a common definition somewhere?

Maybe they need to define ACCESS_OK_USER_LIMIT - which can be
different from TASK_SIZE.

There'll be a few special cases, but most architectures have
kernel addresses above userspace ones.

	David
