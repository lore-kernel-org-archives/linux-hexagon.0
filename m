From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] [v2] hexagon: use generic strncpy/strnlen from_user
Date: Mon, 17 May 2021 08:16:35 +0200
Message-ID: <20210517061635.GA23581@lst.de>
References: <20210515101803.924427-1-arnd@kernel.org> <20210515101803.924427-4-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20210515101803.924427-4-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Sid Manning <sidneym@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger

On Sat, May 15, 2021 at 12:18:00PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most per-architecture versions of these functions are broken in some form,
> and they are almost certainly slower than the generic code as well.
> 
> Remove the ones for hexagon and instead use the generic version.
> This custom version reads the data twice for strncpy() by doing an extra
> strnlen(), and it apparently lacks a check for user_addr_max().

I'd be tempted to just remove the first paragraph and reword the second
as:

Remove the hexagon implementation of strncpy/strnlen and instead use the
generic versions.  The hexago version of strncpy reads the data twice by
doing an extra strnlen(), and it apparently lacks a check for
user_addr_max().
