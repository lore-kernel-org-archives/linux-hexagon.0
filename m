From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: (subset) [PATCH 00/17] -Wmissing-prototype warning fixes
Date: Mon, 28 Aug 2023 08:42:39 +0200
Message-ID: <CAMuHMdUkZmkBSksvaGcDCKz2tsgkwyWgDa+WwCJm2UxFMCj1jw@mail.gmail.com>
References: <20230810141947.1236730-1-arnd@kernel.org> <169292577153.789945.11297239773543112051.b4-ty@oracle.com>
 <3956e2a4-c545-1212-e95f-3cf61a60d6a4@gmail.com> <CAMuHMdWC2S330_Vb_NTHTDC=BakBsw4ouP-eFJv0erV1-jmvTQ@mail.gmail.com>
 <130b3b57-edb0-184d-5b5f-69b013715773@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bkLPsPpo4LPx/sd1gmsEiHyPyVa+//Cny0gH37rJSug=; b=1mpcNBKK406+RG
	rymC1dlNEANF4OAl3NPoC4/xNfKxd+CxrRwZfNhUJH/8+Sljz0NITU1HsogfrKEOitsJlMfvQ2n+n
	QiF7GwlLXyUEfcn8AvmvqjoN6FyZu+GMJrwOs+T0+sAk5V3oJ4ZMLxGM3EonaSQheDyNzmdxmXDf2
	9fYgHUKY3uCN+DLhXQqowzHL+/8bNy+JECco/b5lKXqp6g0uL+GPit5cE8bxKcQDxqPQFk/s/Um5r
	uenhaUD/6Thd/jheSrDF2CmPV47AiCAJvBRYSgVUs38nkD29OXgCIsbGW1cbai3JqwUVUwg1RkBM8
	+OEFH+luI3YsYTRG8Bzw==;
In-Reply-To: <130b3b57-edb0-184d-5b5f-69b013715773@gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Ch

T24gU2F0LCBBdWcgMjYsIDIwMjMgYXQgMTI6NDTigK9BTSBNaWNoYWVsIFNjaG1pdHogPHNjaG1p
dHptaWNAZ21haWwuY29tPiB3cm90ZToKPiAoSW5jaWRlbnRhbGx5IC0gZGlkIHlvdSBldmVyIHB1
Ymxpc2ggdGhlIG02OGsgZnVsbCBoaXN0b3J5IHRyZWUgYW55d2hlcmUKPiBpbiBnaXQ/KQoKWW91
IG1lYW4gdGhlIGdpdGlmaWVkIHZlcnNpb24gb2YgdGhlIExpbnV4L202OGsgQ1ZTIHRyZWUgUmFs
ZiBjcmVhdGVkCmZvciBtZSBiZWNhdXNlIG15IG1hY2hpbmUgd2Fzbid0IHBvd2VyZnVsIGVub3Vn
aD8KTm8sIGFuZCBJIHNob3VsZCBsb29rIGludG8gZG9pbmcgdGhhdC4uLgoKR3J7b2V0amUsZWV0
aW5nfXMsCgogICAgICAgICAgICAgICAgICAgICAgICBHZWVydAoKLS0gCkdlZXJ0IFV5dHRlcmhv
ZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgt
bTY4ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxl
LCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFs
aXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1yaXNjdiBtYWlsaW5n
IGxpc3QKbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2Cg==
