From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH v5 3/4] arch/*/io.h: remove ioremap_uc in some architectures
Date: Thu, 21 Sep 2023 08:27:14 -0400
Message-ID: <c4a96578-b27c-44fa-82ef-1c5bf43b972a@app.fastmail.com>
References: <20230921110424.215592-1-bhe@redhat.com>
 <20230921110424.215592-4-bhe@redhat.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1695299255; x=1695306455; bh=Xq
	U4+PADbmN/YvqQXLrRCGcZ07y18plfxqgBBJgIpjw=; b=Xdx4hQsTzl4c24llIz
	192HiWdE2r0Z17h7hha/5B+uybwHOw+lHySp5dgSFIyremltJv6BupWCCE7vqAtS
	DUduuni5p7SDjaoxP7Y0c3dI1L3DDC96hM3q6xwLck95D6CeqCmsxrkKZ6Zgv2mQ
	ih8pZz4GlPyAEKT2EByi/sbL53k7F9MpaztW3ubpkI67GluVKqoEgJAoZkJac6xf
	L40yx+zPXQSonM/qQqXr+/44QEGY/LW3tmoWxfCIXGmvbDY8YlzEj56Y1t4Q3Ooi
	aLhMW+mRkUenODaIJ7pTKXCN8HhFkJ2SLPpatk0e1cLMSpNqYk1QxmquZjzyFqfT
	dFiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1695299255; x=1695306455; bh=XqU4+PADbmN/Y
	vqQXLrRCGcZ07y18plfxqgBBJgIpjw=; b=AsHXnvbTE0NoKn8UR1wNiZEQ0Izgl
	oJ1le/svDXQKmB5iunzfl757K0xMqaKgwpjVCaw2UuP2Vt2mi2RMkN55AQsiD+0o
	/NGYpK0Q1N3N8f+y8hlvcaJaEnVYzzUXulTecLj6OPE2kfCABIE81WZlt/TQWRym
	a3YS2kb9o3UDiIqmT6Muw7WaDcpWDjOLS4FEg9ERk6Zsv5Hp/uVcGqvfRusPbRxs
	/TkNZpWQa1QyBFLzjTES+Opz/HvajxF5Bnwti4DvpslyUHWi81WsLXmneMghKGmm
	5uLl0cSZ1BQNDmkjOK4WmcBmk5Rvp6jy4BVNblrnY0nqT6NYPATO7irCQ==
In-Reply-To: <20230921110424.215592-4-bhe@redhat.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-m68k@lists.linux-m68k.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Luis Chamberlain <mcgrof@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Thu, Sep 21, 2023, at 07:04, Baoquan He wrote:
> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
> extension, and on ia64 with its slightly unconventional ioremap()
> behavior. So remove the ioremap_uc() definition in architecutures
> other than x86 and ia64. These architectures all have asm-generic/io.h
> included and will have the default ioremap_uc() definition which
> returns NULL.
>
> This changes the existing behaviour, while no need to worry about
> any breakage because in the only callsite of ioremap_uc(), code
> has been adjusted to eliminate the impact. Please see
> atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.
>
> If any new invocation of ioremap_uc() need be added, please consider
> using ioremap() intead or adding a ARCH specific version if necessary.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Helge Deller <deller@gmx.de>  # parisc
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
