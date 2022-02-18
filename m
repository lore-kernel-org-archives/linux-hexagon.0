From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
Date: Fri, 18 Feb 2022 07:34:50 +0100
Message-ID: <20220218063450.GI22576@lst.de>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-14-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20220216131332.1489939-14-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org, bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org, davem@davemloft.net, richard@nod.at, x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com, akpm@linux-foundation.org, ardb@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org

> +#include <asm-generic/access_ok.h>

Instead of the asm-generic games, shouldn't we just define access_ok in
<linux/uaccess.h> if not already defined by the architecture?
