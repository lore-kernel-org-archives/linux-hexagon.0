From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 0/7] Expect immutable pointer in virt_to_phys/isa_virt_to_bus
 prototypes
Date: Fri, 28 Apr 2023 08:40:51 +0100
Message-ID: <52dd950a-e714-4ebe-a663-4e0ec6463d03@app.fastmail.com>
References: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm2; t=
	1682667698; x=1682754098; bh=IpndvKPF8+ZBYjcJVQBy1hma252/YYop7a9
	JdT/8deI=; b=DclSOfxipXonjr10Zfze2g04tEcMacCmPEMQj9KSUXPgBjVvL3b
	MQo6fuWFJzT27nHJRs74jQBGwTtn2n2KHu5aTUjHmlrE0229hVE5oHF9yZDkS3ew
	p1PmAZmZsXTagjeqlDcNnPsWoMKrE3WDRUgwOnllR2Mxd40mEjio8JDSoZrBhcLY
	EpF/qnQ//QXfqOClL6sTo+6QcKph0TMZrseOTG+p/07lIk+CJDRuw9l1QbbyGXjO
	Eb35nUJHmU87iS3+aXTcjIEw3yWT1ZcEtVJ4ScA81na/2JXShjG0jXm+bNsByN9H
	0auAMaDbwZPPaqpkQeZO7SI/+wjiURWUsIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1682667698; x=1682754098; bh=IpndvKPF8+ZBYjcJVQBy1hma252/YYop7a9
	JdT/8deI=; b=ZK/ac6fyNoZWTXPXbTwDD4R131otN5WDVVkeFrFt0hh+B+HJxI8
	X1G/CekMUpexmmrmmtZG9J6nlcBpYM2so1ttFbssFuvmAd/ypJumITr52uxj1kqy
	Zy5c2xC/bhpYC6ggOg+MvqevGn68/zmzyOJ/3I3FVAlKSomAD5e4Rd6yFIqBKGoS
	hfpNiJGqsm98wDNSPOSseTUhCzwwWb6vjvWT3xqdwN747++XNPbtRAEMqvBh4uIw
	8a5wbLZI4Yp1uAxenqy8Yq0fZoWyfdJOOTsgpDQXZZOenD4BGJ/pbNjPRx5NNA7H
	eRdIwS64tODrt1vngpa6XkfH9l9gVEeJE5g==
In-Reply-To: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
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
Content-Type: text/plain; charset="utf-8"
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-ia64@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-hexagon@vger.kernel.org, Omar Sandoval <osandov@fb.com>, Linux-Arch <linux-arch@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, Mark Brown <broonie@kernel.org>, Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Brian Cain <bcain@quicinc.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Chris Down <chr>

On Sat, Apr 15, 2023, at 12:17, Stanislav Kinsburskii wrote:
> This series is aimed to address compilation warnings when a constant p=
ointer
> is passed to virt_to_phys and isa_virt_to_bus functions:
>
>   warning: passing argument 1 of =E2=80=98virt_to_phys=E2=80=99 discar=
ds =E2=80=98const=E2=80=99=20
> qualifier from pointer target type
>   warning: passing argument 1 of =E2=80=98isa_virt_to_bus=E2=80=99 dis=
cards =E2=80=98const=E2=80=99=20
> qualifier from pointer target type
>
> The change(s) is the same for all architectures, but it's split into a=
 series on
> per-arch basis to simplify applying and testing on the maintainers sid=
e.
>

Looks all good to me. If everyone is happy with it, I'll queue it up
after in the asm-generic tree for 6.5, once rc1 is out.

 Arnd
