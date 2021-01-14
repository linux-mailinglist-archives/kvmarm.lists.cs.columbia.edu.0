Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 526F42F67B3
	for <lists+kvmarm@lfdr.de>; Thu, 14 Jan 2021 18:32:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 67D4B4B23A;
	Thu, 14 Jan 2021 12:32:37 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tNBdZqRCnlo; Thu, 14 Jan 2021 12:32:37 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 340BB4B21A;
	Thu, 14 Jan 2021 12:32:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BEA254B1DA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 12:32:35 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40WZxWWMNDKd for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Jan 2021 12:32:34 -0500 (EST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 7A4774B1B1
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 12:32:34 -0500 (EST)
Received: by mail-ej1-f51.google.com with SMTP id ga15so9393495ejb.4
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Jan 2021 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oaLk6K/ziP0JrSWjUd9yUznepJpKpHz8SodeDVZyc4g=;
 b=GWCGEwBUT89R8ID7PJjuDrp5S3/2qLBz8lkSEggHBoncpJhuQX05ohgD3pibnBXJdi
 W/wjaMWx6cX60jzbnFHzbnh6eCuUIEFyAJ6ZNJbjNBuZcpAFm30vEyoFX0OX7sLCfQ4H
 VBGdlONQQCthSTN9lUkdHxVXmxa5Wwba+So89oDc3hDiAC9lD0o2w3oCuPt9V9T1dNVE
 uS3KkqkupscVrlg43emIU6KBxshTWcjcSyN7OszKlUL3h/iedyxOlz6rn4DfD9f2hWu2
 37xuugp76VAJh3BP8R1ZQyS4EExUjFJSmBGIyEyPgIeSizJ4dmyBRr0xzwBjbW8Z19+S
 31VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oaLk6K/ziP0JrSWjUd9yUznepJpKpHz8SodeDVZyc4g=;
 b=NG6d04tLJ77X6FCa6+DCM55BaPopGG3zQ5TaNm3svHGghE6OWuc1yqfZvTS48RgyBF
 jkdqLxB1xoFwmtEU9qdwkvnS3YtHmdy44y1VWC27m2MtxFwoJC4G+TXc7pUe8jCDLGhV
 p7dsFYOStC1uGjn1TSkO0cRl7io4ZMMRJ2jnG6iEaL4R8GC4T2NDVbImtgDFfN3fkywb
 VckdZ/VhO6stRldBEH6Ap1BQ0lk/gO4omP9OL2DZfNeDCCKf/cw/1HFLVRWCqTvwe51c
 huqDK++o+fpP4iYYfNYUANYeo/4AwCJDQodZZEyzanvMUM62owo4G4wWNn0yyiTFH7/M
 sHxQ==
X-Gm-Message-State: AOAM531N1mUiK7YdwdJ8i3ZfNjTwUn+mQKpWs3jytbbEh14Jo6q5MY8F
 7wSuCnNm3iiHwm9ENhnRMVFpOA==
X-Google-Smtp-Source: ABdhPJyWGuNgbGnfn6qKQQM5KwVrs3KxAw/sQ5/Phdx+0TwP4Nqgd8PsrwlAs/HuCHWwhAWmPewspQ==
X-Received: by 2002:a17:906:17c3:: with SMTP id
 u3mr5870629eje.304.1610645553317; 
 Thu, 14 Jan 2021 09:32:33 -0800 (PST)
Received: from larix.localdomain ([2001:1715:4e26:a7e0:ed35:e18a:5e36:8c84])
 by smtp.gmail.com with ESMTPSA id n2sm2235623ejj.24.2021.01.14.09.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 09:32:32 -0800 (PST)
Date: Thu, 14 Jan 2021 18:33:17 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v13 07/15] iommu/smmuv3: Allow stage 1 invalidation with
 unmanaged ASIDs
Message-ID: <YACAXaG+opCwDFTL@larix.localdomain>
References: <20201118112151.25412-8-eric.auger@redhat.com>
 <1606829590-25924-1-git-send-email-wangxingang5@huawei.com>
 <2e69adf5-8207-64f7-fa8e-9f2bd3a3c4e3@redhat.com>
 <e10ad90dc5144c0d9df98a9a078091af@huawei.com>
 <20201204095338.GA1912466@myrica>
 <2de03a797517452cbfeab022e12612b7@huawei.com>
 <0bf50dd6-ef3c-7aba-cbc1-1c2e17088470@redhat.com>
 <d68b6269-ee99-9ed7-de30-867e4519d104@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d68b6269-ee99-9ed7-de30-867e4519d104@redhat.com>
Cc: Xieyingtai <xieyingtai@huawei.com>, wangxingang <wangxingang5@huawei.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "maz@kernel.org" <maz@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 qubingbing <qubingbing@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Hi Eric,

On Thu, Jan 14, 2021 at 05:58:27PM +0100, Auger Eric wrote:
> >>  The uacce-devel branches from
> >>> https://github.com/Linaro/linux-kernel-uadk do provide this at the moment
> >>> (they track the latest sva/zip-devel branch
> >>> https://jpbrucker.net/git/linux/ which is roughly based on mainline.)
> As I plan to respin shortly, please could you confirm the best branch to
> rebase on still is that one (uacce-devel from the linux-kernel-uadk git
> repo). Is it up to date? Commits seem to be quite old there.

Right I meant the uacce-devel-X branches. The uacce-devel-5.11 branch
currently has the latest patches

Thanks,
Jean
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
