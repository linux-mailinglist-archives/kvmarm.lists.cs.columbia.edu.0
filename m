Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 843D741EFB7
	for <lists+kvmarm@lfdr.de>; Fri,  1 Oct 2021 16:39:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0E3B4B0DD;
	Fri,  1 Oct 2021 10:39:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q+fF1PNh4Cfa; Fri,  1 Oct 2021 10:39:18 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B14884B086;
	Fri,  1 Oct 2021 10:39:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 08ACB4B086
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Oct 2021 10:39:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1B8vOxxGaLid for <kvmarm@lists.cs.columbia.edu>;
 Fri,  1 Oct 2021 10:39:15 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 330BC4A534
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 Oct 2021 10:39:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633099155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PVvLSrhnJOGqjYQs3rxAizBVLwy17MoMN0v9tRrAcY=;
 b=LaUtJ+H3thP6az3UcOamuFuNIR8Iilqse+xO3IEsH+aK970BaRUUKIKvJODBSGnRTmiF7h
 8GtD6uNrCbjtSDwNVcNjBp9FjBzf5bbyjI1Qd40ThLOvOMnf40SpGcXQwQhgaYY3MzxMAc
 64HNkr3RlR8LScSjuupflHcgGgXte9A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-RY56ZYvjNjSujFa2uirhAw-1; Fri, 01 Oct 2021 10:39:14 -0400
X-MC-Unique: RY56ZYvjNjSujFa2uirhAw-1
Received: by mail-ed1-f71.google.com with SMTP id
 x7-20020a50ba87000000b003dabd8354f1so5929101ede.7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 01 Oct 2021 07:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=4PVvLSrhnJOGqjYQs3rxAizBVLwy17MoMN0v9tRrAcY=;
 b=Lk1EygX7CVzAUP7X2GunmoVol+GYF1jMHGjCziBhoWg2fZOfYmiCUrhoVCoVSwbytZ
 c1JZ7B+A45j1L7b2KntEiYUoZLK5mgOE2zD9hI+BHkDqZwR5Vw9nOZsXd/mC3dJbKXBg
 mBtxgC2Vvke+bVssYhaYD6kP1gCnv+XxxpowjgmHTFM4cZiA9wKatVbZ9eO4xU6/rqkt
 JR5hBM10bvIQsMYp/dX6Q/xHe9Rq3TAmncUdGxbLzPeTvv/xosZgjSrPkWdMJsxcM2LB
 3FCjwh0T0iydS3yfWkOVtwQKF7aDTgHqfTL4XPQe9+UxWPNHanrhFO+NzVJAn/mOhPXN
 hfrw==
X-Gm-Message-State: AOAM5314xVWdRUhYEq6Pd1gxO3ydxt+9YYBNuqWa0IiT6EL6phNZ8Wts
 E9VAiHsCqz1gECN8khmqQvSfTW5QUyK+qcs9vzWIMJbXqAA5CoDrj4njkmC+hw00TqJq6VT9Odc
 EZPpqZ7tLdk0UipkGbsWQJZdZ
X-Received: by 2002:a17:906:29d0:: with SMTP id
 y16mr7042813eje.477.1633099152931; 
 Fri, 01 Oct 2021 07:39:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8RlMd0BjSON/zIWBi38A/HrGVeQYpbDZkMC1hM+jwKFzAnK3B/OZXyj61nI9hMjkJ+eOS3w==
X-Received: by 2002:a17:906:29d0:: with SMTP id
 y16mr7042785eje.477.1633099152704; 
 Fri, 01 Oct 2021 07:39:12 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id l25sm3426382eda.36.2021.10.01.07.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Oct 2021 07:39:12 -0700 (PDT)
Message-ID: <d88dae38-6e03-9d93-95fc-8c064e6fbb98@redhat.com>
Date: Fri, 1 Oct 2021 16:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v8 4/7] KVM: x86: Report host tsc and realtime values in
 KVM_GET_CLOCK
To: Oliver Upton <oupton@google.com>, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu
References: <20210916181538.968978-1-oupton@google.com>
 <20210916181538.968978-5-oupton@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210916181538.968978-5-oupton@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Marc Zyngier <maz@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 16/09/21 20:15, Oliver Upton wrote:
> +	if (data.flags & ~KVM_CLOCK_REALTIME)
>   		return -EINVAL;

Let's accept KVM_CLOCK_HOST_TSC here even though it's not used; there 
may be programs that expect to send back to KVM_SET_CLOCK whatever they 
got from KVM_GET_CLOCK.

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
