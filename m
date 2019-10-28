From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH] hexagon: work around compiler crash
Date: Mon, 28 Oct 2019 15:09:52 -0500
Message-ID: <002301d58dcb$a9ffaa80$fdfeff80$@codeaurora.org>
References: <20191028155722.23419-1-ndesaulniers@google.com>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572293395;
        bh=yDqvNVHhioOXiqjnb4f2q03NmQOz4C5aqZuljuDMOF0=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=YcdA17Z8/z0a65m6GazQEoBEp0Y0FHxyklETaAStgGFT8noyV20xlEJvEBdKpZSQA
         Tn5+YITS2CbbohG1+J2WlWa3PJvR9yENTuoeKFXhZmKbUK/HDUQZfeVtCsn66lpeAQ
         uKtSp2Tjuc/8w1mJPR0Q6cyzsMXX0u0EROCjeyj4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572293394;
        bh=yDqvNVHhioOXiqjnb4f2q03NmQOz4C5aqZuljuDMOF0=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=mCdCEyDrGyipu0nnGPB7/pULaO1iagaTJbBnIwPaqNbrEjzy4xSUGxTtGbzTYxxoV
         zDzZioBviFtj/O3Vo3pJVC2UTNaeUQ9KaE+0Hu4aB0AoCksBpy6x8gkbGfGCTDdP4L
         1tNTNv5Fr+bmXe+VaH2WFXYI2/wrQUjM+6t4FSjs=
In-Reply-To: <20191028155722.23419-1-ndesaulniers@google.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Nick Desaulniers' <ndesaulniers@google.com>
Cc: 'Sid Manning' <sidneym@quicinc.com>, 'Allison Randal' <allison@lohutok.net>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Richard Fontana' <rfontana@redhat.com>, 'Thomas Gleixner' <tglx@linutronix.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> owner@vger.kernel.org> On Behalf Of Nick Desaulniers
...
> Subject: [PATCH] hexagon: work around compiler crash
> 
> Clang cannot translate the string "r30" into a valid register yet.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/755
> Suggested-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

LGTM.  Thanks, Nick.

Reviewed-by: Brian Cain <bcain@codeaurora.org>

