From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 2/2] arch/*/io.h: remove ioremap_uc in some
 architectures
Date: Tue, 7 Mar 2023 09:30:43 +0800
Message-ID: <ZAaTw+841xBsz/m9@MiWiFi-R3L-srv>
References: <20230303102817.212148-1-bhe@redhat.com>
 <20230303102817.212148-3-bhe@redhat.com>
 <87sfej1rie.fsf@mpe.ellerman.id.au>
 <CAMuHMdXoM24uAZGcjBtscNMOSY_+4u08PEOR7gOfCH7jvCceDg@mail.gmail.com>
 <5dec69d0-0bc9-4f6c-8d0d-ee5422783100@app.fastmail.com>
 <87jzzt1ioc.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678152652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8ahPZDaVvcIaob1vmzodN2QF3Hw6BRjjqbc38rwl/Q=;
	b=O+5u2ExgaOEshTO2YlxXEqsOYa9P8aLq+BzqYmkLgDP4hjQfWutktreaxOZGpZwr43cMke
	9yPlGUQ9I3qKMYepfg9uo34rtnrrRWjhZyV4eYuEaC7QA8N9UrWqm5sPzup6mCSHHMo1Mx
	ZL83l03NTiRK36rVWF+00Z6FDBfOcaE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678152652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8ahPZDaVvcIaob1vmzodN2QF3Hw6BRjjqbc38rwl/Q=;
	b=O+5u2ExgaOEshTO2YlxXEqsOYa9P8aLq+BzqYmkLgDP4hjQfWutktreaxOZGpZwr43cMke
	9yPlGUQ9I3qKMYepfg9uo34rtnrrRWjhZyV4eYuEaC7QA8N9UrWqm5sPzup6mCSHHMo1Mx
	ZL83l03NTiRK36rVWF+00Z6FDBfOcaE=
Content-Disposition: inline
In-Reply-To: <87jzzt1ioc.fsf@mpe.ellerman.id.au>
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
Content-Type: text/plain; charset="windows-1252"
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 03/07/23 at 11:58am, Michael Ellerman wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
> > On Sun, Mar 5, 2023, at 10:29, Geert Uytterhoeven wrote:
> >> On Sun, Mar 5, 2023 at 10:23=E2=80=AFAM Michael Ellerman <mpe@ellerman=
.id.au> wrote:
> >>> Maybe that exact code path is only reachable on x86/ia64? But if so
> >>> please explain why.
> >>>
> >>> Otherwise it looks like this series could break that driver on powerpc
> >>> at least.
> >>
> >> Indeed.
> >
> > When I last looked into this, I sent a patch to use ioremap()
> > on non-x86:
> >
> > https://lore.kernel.org/all/20191111192258.2234502-1-arnd@arndb.de/
>=20
> OK thanks.
>=20
> Baoquan can you add that patch to the start of this series if/when you
> post the next version?

Sure, will do. Wondering if we need make change to cover powerpc other
than x86 and ia64 in Arnd's patch as you and Geert pointed out.

