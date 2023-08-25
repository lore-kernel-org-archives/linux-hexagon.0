From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: (subset) [PATCH 00/17] -Wmissing-prototype warning fixes
Date: Fri, 25 Aug 2023 13:30:32 +1200
Message-ID: <3956e2a4-c545-1212-e95f-3cf61a60d6a4@gmail.com>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <169292577153.789945.11297239773543112051.b4-ty@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XRFsbK80JiiYgBMmV8RvEOuPBOvu6E1CA9lCpvaM+bI=; b=nqn6e612I/dV4l
	MCxQlmSonPEPYJJR+b+84hjmFRaqT9fjXXPT0RwKHt58mxSFmEpZs43P9ZY0RilEuwHWu2q27Yzrk
	rddvQWlIvh1WA8RAS662F1jMwRMBQ6Zvv1TWWg/1OSZ8UqNwVJZECQJWH7tFU+2e790guo6UC44Ti
	n5kF7sNJaJ/lRr7WC/w4IEZ1zoIvXxgDHvMI7nGuYkiXugLtZf7KOIgvwPjysMKwZKHnDRwL/VU1g
	kgBLkeSUri654a5eZGviQAz1ilPwSKzQ+4NejMKkpJ1A/lGJDK0te7QMsLhNOBHnF9GTPShvW7pAJ
	zSbU8Ug6vn1RrK4iJjvA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692927057; x=1693531857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7ELdHtTL5wYh7Mk37fDEn5rWUjAm0EdSJQg/6HWPPQ=;
        b=Tmlz4s2OgK58rZBzZOqQBOTKsewJsSbr0lEcw148TWgipwzPC4h3leu6DHGlT2r85/
         Uip0aLw7OTRJ61MyT/fB+2M0fG4g6LWvilyhBIrARSkzuGacd0puWelGLD8sQFEorTQR
         iWM9dveRRwtXAAMgsQ1/wPN9YLRbtznx8UH3GB/Gc6Kl2jKJWnRhPY+VLZrWbWEKV9yS
         nafEaqYDFpVR5/DPJmFBDt9xOQCxtCGGHTqymDFSbzyjxleu1nAu7M/vlGloF4CFWAV1
         1Mn9tQCCGOF3Z8ZylRnT1zAlhIOy4YB5/0u2bxeQjx03+CoamjdoA+ECCtWPkVPf8KF0
         7rAQ==
Content-Language: en-US
In-Reply-To: <169292577153.789945.11297239773543112051.b4-ty@oracle.com>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>, J

SGkgTWFydGluLCBBcm5kLAoKT24gMjUvMDgvMjMgMTM6MTIsIE1hcnRpbiBLLiBQZXRlcnNlbiB3
cm90ZToKPiBPbiBUaHUsIDEwIEF1ZyAyMDIzIDE2OjE5OjE4ICswMjAwLCBBcm5kIEJlcmdtYW5u
IHdyb3RlOgo+Cj4+IE1vc3Qgb2YgdGhlIHBhdGNoZXMgSSBzZW50IHNvIGZhciBmb3IgdGhlIC1X
bWlzc2luZy1wcm90b3R5cGUgd2FybmluZ3MKPj4gaGF2ZSBtYWRlIGl0IGludG8gbGludXgtbmV4
dCBub3cuIFRoZXJlIGFyZSBhIGZldyB0aGF0IEknbSByZXNlbmRpbmcKPj4gbm93IGFzIG5vYm9k
eSBoYXMgcGlja2VkIHRoZW0gdXAsIGFuZCB0aGVuIGEgbnVtYmVyIG9mIGZpeGVzIHRoYXQgSQo+
PiBmb3VuZCB3aGlsZSB0ZXN0LWJ1aWxkaW5nIGFjcm9zcyBhbGwgYXJjaGl0ZWN0dXJlcyByYXRo
ZXIgdGhhbiBqdXN0IHRoZQo+PiBvbmVzIEkgdXN1YWxseSB0ZXN0Lgo+Pgo+PiBUaGUgZmlyc3Qg
MTUgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcyBzaG91bGQgYmUgdW5jb250cm92ZXJzaWFsLCBzbwo+
PiBJIGV4cGVjdCB0aGF0IGVpdGhlciBhIHN1YnN5c3RlbSBtYWludGFpbmVyIG9yIEFuZHJldyBN
b3J0b24gY2FuCj4+IGFwcGx5IHRoZXNlIGRpcmVjdGx5Lgo+Pgo+PiBbLi4uXQo+IEFwcGxpZWQg
dG8gNi42L3Njc2ktcXVldWUsIHRoYW5rcyEKPgo+IFswNy8xN10gc2NzaTogcWxvZ2ljcHRpOiBt
YXJrIHFsb2dpY3B0aV9pbmZvKCkgc3RhdGljCj4gICAgICAgICAgaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9ta3Avc2NzaS9jLzcxY2M0ODYzMzVjNAo+IFsxMS8xN10gc2NzaTogZ3ZwMTE6IHJlbW92
ZSB1bnVzZWQgZ3ZwMTFfc2V0dXAoKSBmdW5jdGlvbgo+ICAgICAgICAgIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvbWtwL3Njc2kvYy9iZmFhNGEwY2UxYmIKCkkgc29tZWhvdyBtaXNzZWQgdGhhdCBv
bmUgLi4uCgpUaGUgZ3ZwMTFfc2V0dXAoKSBmdW5jdGlvbiB3YXMgcHJvYmFibHkgYSByZWxpYyBm
cm9tIHRoZSB0aW1lcyBiZWZvcmUgCm1vZHVsZSBwYXJhbWV0ZXJzLgoKU2luY2UgZ3ZwMTFfeGZl
cl9tYXNrIGFwcGVhcnMgdG8gYmUgcmVxdWlyZWQgZm9yIHNvbWUgQW1pZ2Egc3lzdGVtcyB0byAK
c2V0IHRoZSBETUEgbWFzaywgSSdkIGJlc3Qgc2VuZCBhIHBhdGNoIHRvIGFkZCBzdWNoIGEgbW9k
dWxlIHBhcmFtZXRlciAuLi4KCkRvIHlvdSBrbm93IGFueSBkZXRhaWxzIGFyb3VuZCB0aGUgdXNl
IG9mIERNQSBtYXNrcyBmb3IgQW1pZ2EgV0QzM0M5MyAKZHJpdmVycywgR2VlcnQ/CgpDaGVlcnMs
CgogwqDCoMKgIE1pY2hhZWwKCgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QKbGludXgtcmlzY3ZAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXJpc2N2Cg==
