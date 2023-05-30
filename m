From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] Hexagon: Replace all non-returning strlcpy with strscpy
Date: Tue, 30 May 2023 16:20:58 -0700
Message-ID: <202305301620.52B9CAC512@keescook>
References: <20230530162608.984333-1-azeemshaikh38@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488859; x=1688080859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc7vYtyLdqVYJlU5zArPBdwQtjT1hwksutVKyiK2hts=;
        b=RtPOvBx3dMlTDpe5c0TAtd0y9Qiu8xj+GDcQbPfPV6YQuOZqmHe1nzftLegPTWVC0m
         mHLFvnsGa2fjECeOc1fJZ0mhJcVPVQJchWzNFW0Rt4Sq+TDlebqDgNKELlMzewvMrcVI
         ueVdwLUUz8VblSnY+SJnhGcOYbbtLKRK2O+Yg=
Content-Disposition: inline
In-Reply-To: <20230530162608.984333-1-azeemshaikh38@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Brian Cain <bcain@quicinc.com>, linux-hardening@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:26:08PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
