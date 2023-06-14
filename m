From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] Hexagon: Replace all non-returning strlcpy with strscpy
Date: Wed, 14 Jun 2023 11:18:31 -0700
Message-ID: <168676670780.1815023.2376604888079665488.b4-ty@chromium.org>
References: <20230530162608.984333-1-azeemshaikh38@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686766742; x=1689358742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DVA52p4YcILRY7L9DFLvbAPwmdSgMbGdjvMaWJxlDM=;
        b=gSR6K+IoSV4UcCbyThkovBW84pwErtTdN1Lf7dIi/cT8a82OBj/zR29k4NSaiwqtOV
         7cF8XAMnN61CQS7d0sNglKn71UYX2nesvdOVddooAVbOyKrTIZZKSCtAY9RE9t6DzcWb
         VjfBQ8FsLUvPZiGPjEyfjN+9oZ0Yo1ktN6GfA=
In-Reply-To: <20230530162608.984333-1-azeemshaikh38@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: azeemshaikh38@gmail.com, bcain@quicinc.com
Cc: Kees Cook <keescook@chromium.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

On Tue, 30 May 2023 16:26:08 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Successfully build tested with Clang 17.

Applied to for-next/hardening, thanks!

[1/1] Hexagon: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/f0e212de87a1

-- 
Kees Cook

