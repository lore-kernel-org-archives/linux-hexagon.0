From: afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: Re: [PATCH v3] hexagon: replace setup_irq() by request_irq()
Date: Fri, 13 Mar 2020 17:56:04 +0530
Message-ID: <20200313122604.GB7004@afzalpc>
References: <20200304004910.4842-1-afzal.mohd.ma@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TQY2dP5m8YWIYIwR1A/LK0PlPaEsfxw7E8OVjboitjQ=;
        b=tAmYP74yWEUEUSRtVwi97Pa3dhGvdU8PBoJPdSt9kIDXUL9CY4ABDPoKndyfj/9FOU
         64PLyMf/iqmK95p3M4agKwEZzHxFVcFmb1nQk/LD1229o3OQz4d3zFzRHEccTQgruRdE
         ED2o1f5zV464viVKxcayxIUURhDSZQaFNqRm/R50eQ6MspeqGfnY6npLp+4GnEjQOyXA
         DDxDUbv0sxjuQ431fKAPreidlHpdidrWYrnYLyBvtKvp0T7+ra3iikZRdimXgwb2VGFv
         gd7T5zrdoWYtdXT6p2urw5VpgNjEs5PM0xw7ehZ3nbz5nWXGl9vnQolGr2uE4rKM2jhA
         93NA==
Content-Disposition: inline
In-Reply-To: <20200304004910.4842-1-afzal.mohd.ma@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Brian Cain,

On Wed, Mar 04, 2020 at 06:19:09AM +0530, afzal mohammed wrote:

> Hi hexagon maintainers,
> 
> if okay w/ this change, please consider taking it thr' your tree, else please
> let me know.

Per get_maintainers script, there are no maintainers, only a support
in you, seems you are not sedning pull requests for hexagon. If you
are okay w/ this change, can you please ack it so as to be routed via
tglx.

Regards
afzal
