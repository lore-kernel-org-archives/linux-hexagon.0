From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
Date: Tue, 15 Feb 2022 00:48:03 +0000
Message-ID: <Ygr4Q2/KxfF86ETa@zeniv-ca.linux.org.uk>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-12-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-12-arnd@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org, bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org, davem@davemloft.net, richard@nod.at, x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com, akpm@linux-foundation.org, ardb@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.in

On Mon, Feb 14, 2022 at 05:34:49PM +0100, Arnd Bergmann wrote:

> -/*
> - * Sparc64 is segmented, though more like the M68K than the I386.
> - * We use the secondary ASI to address user memory, which references a
> - * completely different VM map, thus there is zero chance of the user
> - * doing something queer and tricking us into poking kernel memory.

Actually, this part of comment probably ought to stay - it is relevant
for understanding what's going on (e.g. why is access_ok() always true, etc.)
