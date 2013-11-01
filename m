From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH] hexagon: include: asm: kgdb: extend DBG_MAX_REG_NUM for "cs0/1"
Date: Fri, 1 Nov 2013 12:14:08 -0500
Message-ID: <CAHrUA37bWiYZoSwoqTEQoXu92WK6UpRv9fAG3F0ZvTvS4f97iQ@mail.gmail.com>
References: <527396BA.7050906@asianux.com>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/qA/WS2i0cE18UNszgHzgaNoQBPzfjGNpePxPTnwCcc=;
        b=TX55hWMux/GtyqEpICfWJpWEESKAN3o5RLprVkamBe8vtmOGLnKgTZJIzMkp/2Tv0V
         Pk1N1vTMcaMv26SRODUKzc2PPvz68vIeGS3NLDIisr3j5it0ltNSyOQpVu1thd1CUlru
         4S0eR4SAKMPclAEFVybEjAG1Vfo33Rj726kd6dl3lIWbxG4vbvDGBUQo6kUKSexNiCgw
         cn6WXLnWKBDPnJWUsGadUdFue47iu1FGM+l5vx9p6oWT5CGLfB55P5Wvc4I2VNlOrKX8
         KdANTSkxufL4n8VD72LOtQIg+T3TodQH+8cfDDEBbysjVSelLdB8c6QAG49sv0a8cA1g
         bS4Q==
In-Reply-To: <527396BA.7050906@asianux.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gang <gang.chen@asianux.com>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

On 1 November 2013 06:55, Chen Gang <gang.chen@asianux.com> wrote:
> Need extend maximized number for "cs0/1", the related warning (with
> allmodconfig for v4):

Looks ok to me.

Acked-by: Linas Vepstas <linasvepstas@gmail.com>
