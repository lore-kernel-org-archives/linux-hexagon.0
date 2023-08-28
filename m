From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: (subset) [PATCH 00/17] -Wmissing-prototype warning fixes
Date: Mon, 28 Aug 2023 20:07:27 +1200
Message-ID: <dbed3311-6b8e-a396-7e9e-2747902c5d6a@gmail.com>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <169292577153.789945.11297239773543112051.b4-ty@oracle.com>
 <3956e2a4-c545-1212-e95f-3cf61a60d6a4@gmail.com>
 <CAMuHMdWC2S330_Vb_NTHTDC=BakBsw4ouP-eFJv0erV1-jmvTQ@mail.gmail.com>
 <130b3b57-edb0-184d-5b5f-69b013715773@gmail.com>
 <CAMuHMdUkZmkBSksvaGcDCKz2tsgkwyWgDa+WwCJm2UxFMCj1jw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cCmgIaYJCF2gGapsUCwS+GsTC4RYiJP6NahEH2YlDN8=; b=jc8ORqz6m/s4F/4XZHAV2db0L4
	Hf9Cq9xJfUmqofhnkjUWxWGR61Veu3BX+0CquqUyiUAJSSAZiMxxrrPLHoZtIlHQ97Y86V0t7iOF6
	Sa6MJ2TcEV4FMDURIJipntNgO3uMlytdGvd2+CX8RSRLUuTAD5G1JzNYKumVLe/QvH4Cud8fsGqIw
	4RZzoXiEGmusAjg/A4gL1eHIy9A40GVvcT/TnIerTbmK20XpDwu1NJsxVQPOI56Jfh+Zl/hvJLXxB
	VTA0oij9Hb9BJW888HnuLfP04OGCjBERHN7HRinMDcklY80XgM3FBAshZUL6pGVTR/SP1yDQMdESY
	h3zbrO9Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693210077; x=1693814877;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnrE6dyfVAprK/xFUC60jFewyVljQRt3NNtTMulp0V0=;
        b=LVg55P2ejT0BJXH9H1+hgJHcBL2A+IF5g+KpwZsnJ2WoqXmcrL9ZfEfa3T6fNEdxE+
         ga2nqaZ+gZjmffBcNuVnaXDtmvodkJeUEflTba5i6j/rIlhBduWdBgZRPVnHwy+erFMo
         Q2sF5ZgAuDt+03EKZEd8qEogPdBU5cTg8EccDlTx6cSnC2QLYfomUfDCZyZGJl19L0Ry
         zfDO9BgqWN0KlkikpK3fWA7KZvQWChySAj+L6JXiUhVTo7xH2gRnW3f4Al2lAGJTZzAW
         5ZruNkogVGDYB3ptB7Tk7PeewBGyh+fZdTDyBJ7/jPzoGq3RnYeGV17VCUydj0j+5OXO
         MJDA==
In-Reply-To: <CAMuHMdUkZmkBSksvaGcDCKz2tsgkwyWgDa+WwCJm2UxFMCj1jw@mail.gmail.com>
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
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christo

SGkgR2VlcnQsCgpBbSAyOC4wOC4yMDIzIHVtIDE4OjQyIHNjaHJpZWIgR2VlcnQgVXl0dGVyaG9l
dmVuOgo+IE9uIFNhdCwgQXVnIDI2LCAyMDIzIGF0IDEyOjQ04oCvQU0gTWljaGFlbCBTY2htaXR6
IDxzY2htaXR6bWljQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IChJbmNpZGVudGFsbHkgLSBkaWQgeW91
IGV2ZXIgcHVibGlzaCB0aGUgbTY4ayBmdWxsIGhpc3RvcnkgdHJlZSBhbnl3aGVyZQo+PiBpbiBn
aXQ/KQo+Cj4gWW91IG1lYW4gdGhlIGdpdGlmaWVkIHZlcnNpb24gb2YgdGhlIExpbnV4L202OGsg
Q1ZTIHRyZWUgUmFsZiBjcmVhdGVkCj4gZm9yIG1lIGJlY2F1c2UgbXkgbWFjaGluZSB3YXNuJ3Qg
cG93ZXJmdWwgZW5vdWdoPwoKVGhlIHZlcnkgc2FtZSAuLi4KCj4gTm8sIGFuZCBJIHNob3VsZCBs
b29rIGludG8gZG9pbmcgdGhhdC4uLgoKTm8gcHJlc3N1cmUhCgpDaGVlcnMsCgoJTWljaGFlbAoK
Pgo+IEdye29ldGplLGVldGluZ31zLAo+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQK
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
cmlzY3YgbWFpbGluZyBsaXN0CmxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdgo=
