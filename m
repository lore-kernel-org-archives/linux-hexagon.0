From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 5/9] csky: use generic strncpy/strnlen from_user
Date: Thu, 22 Jul 2021 15:01:17 +0200
Message-ID: <20210722130117.GE26225@lst.de>
References: <20210722124814.778059-1-arnd@kernel.org> <20210722124814.778059-6-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20210722124814.778059-6-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Al Viro <viro@zeniv.linux.org.uk>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Brian Cain <bcain@codeaurora.org>, Chris Zankel <chris@zankel.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>, Linus Walleij <linus.walleij@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori

On Thu, Jul 22, 2021 at 02:48:10PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Remove the csky implemenation of strncpy/strnlen and instead use the
> generic versions.  The csky version is fairly slow because it always does
> byte accesses even for aligned data, and it lacks a checks for
> user_addr_max().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
